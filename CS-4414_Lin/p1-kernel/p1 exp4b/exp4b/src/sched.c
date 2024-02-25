#include "sched.h"
#include "irq.h"
#include "printf.h"
#include "timer.h"

static struct task_struct init_task = INIT_TASK;
struct task_struct *current = &(init_task);
struct task_struct * task[NR_TASKS] = {&(init_task), };
int nr_tasks = 1;

int next_pid = 1;
int current_pid = 0;
int switch_count = 0; // keep track of the number of switches
struct message_struct * messages[50] = {};
static struct message_struct init_msg = INIT_MSG;
struct message_struct * tmp_msg_struct =&(init_msg);

void preempt_disable(void)
{
	current->preempt_count++;
}

void preempt_enable(void)
{
	current->preempt_count--;
}


void _schedule(void)
{
	/* ensure no context happens in the following code region
		we still leave irq on, because irq handler may set a task to be TASK_RUNNING, which 
		will be picked up by the scheduler below */
	preempt_disable(); 
	int next, c;
	struct task_struct * p;
	while (1) {
		c = -1; // the maximum counter of all tasks 
		next = 0;

		/* Iterates over all tasks and tries to find a task in 
		TASK_RUNNING state with the maximum counter. If such 
		a task is found, we immediately break from the while loop 
		and switch to this task. */

		for (int i = 0; i < NR_TASKS; i++){
			p = task[i];
			if (p && p->state == TASK_RUNNING && p->counter > c) {
				c = p->counter;
				next = i;
			}
		}
		if (c) {
			break;
		}

		/* If no such task is found, this is either because i) no 
		task is in TASK_RUNNING state or ii) all such tasks have 0 counters.
		in our current implemenation which misses TASK_WAIT, only condition ii) is possible. 
		Hence, we recharge counters. Bump counters for all tasks once. */
		
		for (int i = 0; i < NR_TASKS; i++) {
			p = task[i];
			if (p) {
				p->counter = (p->counter >> 1) + p->priority;
			}
		}
	}
	
	store_current_pid();
	current_pid = next;
	switch_to(task[next]);
	preempt_enable();
	store_message();

}

void schedule(void)
{
	current->counter = 0;

	_schedule();
}

void switch_to(struct task_struct * next) 
{
	if (current == next) 
		return;
	struct task_struct * prev = current;
	current = next;

	/*	 
		below is where context switch happens. 

		after cpu_switch_to(), the @prev's cpu_context.pc points to the instruction right after  
		cpu_switch_to(). this is where the @prev task will resume in the future. 
		for example, shown as the arrow below: 

			cpu_switch_to(prev, next);
			80d50:       f9400fe1        ldr     x1, [sp, #24]
			80d54:       f94017e0        ldr     x0, [sp, #40]
			80d58:       9400083b        bl      82e44 <cpu_switch_to>
		==> 80d5c:       14000002        b       80d64 <switch_to+0x58>
	*/
	record_timestamp();
	increment_switch_count();
	cpu_switch_to(prev, next);  /* will branch to @next->cpu_context.pc ...*/
	store_next_pid();

	// if(switch_count == 10) {
	// 	printf("Switch Count is now 10\n");
	// }
}

void schedule_tail(void) {
	preempt_enable();

}


void timer_tick()
{
	--current->counter;
	if (current->counter > 0 || current->preempt_count > 0) 
		return;
	current->counter=0;

	/* Note: we just came from an interrupt handler and CPU just automatically disabled all interrupts. 
		Now call scheduler with interrupts enabled */
	enable_irq();
	_schedule();
	/* disable irq until kernel_exit, in which eret will resort the interrupt flag from spsr, which sets it on. */
	disable_irq(); 

}

// get pid of current task
int getpid(void) {
	return current_pid;
}


// STORE INTO THE MSG STRUCT
void increment_switch_count(void) {
	switch_count++;
}


void print_msg( struct message_struct * msg_struct ) {

	//sample message: 1234 from task1 (PC 0x81000 SP 0x83F00) to task2 (PC 0x82000 SP 0x85F00)
	printf("%d from task%d (PC %x SP %x) to task%d (PC %x SP %x)\n", msg_struct -> timestamp, msg_struct -> pid_in, msg_struct -> pc_in,
	msg_struct -> sp_in, msg_struct -> pid_out, msg_struct -> pc_out, msg_struct -> sp_out);
}

	//TODO: store the timestamp
void record_timestamp(void) {
	tmp_msg_struct -> timestamp = get_time_ms(); 
}

void store_message(void) {
	struct message_struct m = * tmp_msg_struct; 
	messages[switch_count - 1] = &m;
}

void store_current_sp_pc(long sp, long pc) {
	tmp_msg_struct -> sp_in = sp;
	tmp_msg_struct -> pc_in = pc;
}

void store_incoming_sp_pc(long pc, long sp) {
	tmp_msg_struct -> sp_out = sp;
	tmp_msg_struct -> pc_out = pc;
}

void store_current_pid(void) {
	tmp_msg_struct -> pid_in = getpid();
}

void store_next_pid(void) {
	tmp_msg_struct -> pid_out = getpid();
}

void print_msgs(void ) {
	printf("message.....");
}