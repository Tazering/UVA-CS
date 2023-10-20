import java.util.*;

/*
 * This class simulates a non-deterministic finite automata
 * @author Floryan
 */
public class NFA{

	/* This global counter is used to issue numbers to each state one at a time as they are added */
	/* Helps us guarantee that all state numbers are unique, which is convenient */
	private static Integer ID_Counter = 0;

	/* Variables that define the machine itself. */
	/* States are labeled by increasing integers */
	private HashSet<Integer> states;
	private HashMap<QSig, HashSet<Integer>> transitions;
	/* Sigma is just 'a', 'd', 'e' (epsilon). No need to represent explicitly */
	private Integer startState;
	private HashSet<Integer> finalStates;


	/* Constructor. Creates a machine with a single start state only! */
	public NFA(){
		states = new HashSet<Integer>();

		transitions = new HashMap<QSig, HashSet<Integer>>();
		startState = addState(); //add one start state and remember it
		finalStates = new HashSet<Integer>();
	}

	/* Adding state with next available unique ID number */
	public int addState(){
		states.add(ID_Counter);
		ID_Counter++;
		return ID_Counter-1;
	}

	/* You can use this internally to manually add a specific state */
	/* Should only be used when you are merging states with another machine */
	private int addState(int stateId){
		states.add(stateId);
		return stateId;
	}

	/* Translate input to a or d */
	/* Be careful of 'e' the letter versus 'e' as epsilon transition */
	/* You do not want to call this on an 'e' epsilon transition accidentally */
	private char translateInput(char sig){
		if(sig >= 'a' && sig <= 'z') return 'a';
		else if(sig >= '0' && sig <= '9') return 'd';
		else return sig;
	}


	/* Creating and removing transitions */
	public boolean addTransition(int state, char sig, int newState){
		/* Make sure the inputs are all valid */
		if(!states.contains(state)) return false;
		if(!states.contains(newState)) return false;

		/* Create the transition and add it if it does not already exist */
		QSig qs = new QSig(state, sig);

		/* If first time seeing this, create the vector of destination states */
		if(!transitions.containsKey(qs)) transitions.put(qs, new HashSet<Integer>());

		/* add or overwrite it */
		transitions.get(qs).add(newState);
		return true;
	}

	/* Easier way to grab transitions */
	public boolean hasTransition(int state, char inputChar){
		QSig qs = new QSig(state, inputChar);
		return transitions.containsKey(qs);
	}

	public HashSet<Integer> getTransitions(int state, char inputChar){
		QSig qs = new QSig(state, inputChar);
		return transitions.get(qs); //might be null FYI
	}


	/* Setting / changing the start state */
	public boolean setStartState(int startState){
		/* Make sure state is one of the valid states */
		if(!states.contains(startState)) return false;

		this.startState = startState;
		return true;
	}

	public int getStartState(){
		return this.startState;
	}


	/* Setting / changing the final state(s) */
	public boolean clearFinalStates(){
		finalStates.clear();
		return true;
	}

	public boolean addFinalState(int state){
		if(!states.contains(state)) return false;
		if(finalStates.contains(state)) return false;

		finalStates.add(state);
		return true;
	}

	/* Performs all transitions for one character of input. */
	/* Removes the old state from the state list */
	/* Adds new states to the state list */
	/* Returns the new set of states the machine is in */
	public HashSet<Integer> transition(HashSet<Integer> curStates, char input){

		/* These states will be removed */
		HashSet<Integer> newStates = new HashSet<Integer>();

		for(int state : curStates){
			if(hasTransition(state, input))
				newStates.addAll(getTransitions(state, input));
		}

		return newStates;
	}

	/* Handles all epsilon transitions one time */
	/* Returns new set of states the machine is in */
	public HashSet<Integer> epsilonTransition(HashSet<Integer> curStates){

		while(true){
			HashSet<Integer> toAdd = new HashSet<Integer>();
			int initSize = curStates.size();
			for(int state: curStates){
				if(hasTransition(state, 'e'))
					toAdd.addAll(getTransitions(state, 'e'));
			}
			/* Break once no new states added */
			curStates.addAll(toAdd);
			if(initSize == curStates.size()) break;
			
		}
		return curStates;
	}

	/*
	 * Most important method. Given a string, does the NFA accept it?
	 */
	public boolean acceptsString(String input){
		
		/* Keep track of states and add start state */
		HashSet<Integer> currentStates = new HashSet<Integer>();
		currentStates.add(startState);

		/* --------------------------------- */
		/* TODO: IMPLEMENT THIS METHOD */
		/* --------------------------------- */

		// loop through all the characters in the input to get the new set of states
		char[] chars = input.toCharArray();
		for(char c : chars) {
			currentStates = epsilonTransition(currentStates); // keep checking for epsilon transitions
			currentStates = transition(currentStates, c); // get new current states after a transition of a character 'c'
		}

		// check if any of the states in the current states is a final state
		// if a state is found -> return True
		for(Integer state : currentStates) {
			if(finalStates.contains(state)) {
				return true;
			}
		}

		/* --------------------------------- */

		return false;
	}


	/* Applies the * operator to this machine. */
	public void star(){
		
		/* --------------------------------- */
		/* TODO: IMPLEMENT THIS METHOD */
		/* --------------------------------- */

		/*
			1. create dummy start node
			2. add transition from dummy start node to this start node
			3. add transitions from all final states to this start state
			4. set start state to dummy start node
			5. make dummy start node as final node as well
		 */

		int dummy_state = addState(); // creates dummy start node

		this.addTransition(dummy_state, 'e', this.startState); // creates the transition

		for(Integer end_state : this.finalStates) { // final nodes to old start node
			this.addTransition(end_state, 'e', this.startState);
		}

		this.setStartState(dummy_state); // resets start state

		this.finalStates.add(dummy_state); // set dummy start node as final node

		/* --------------------------------- */


		
	}

	/* Applies the union operator. Changes this machine but not the parameter */
	public void union(NFA other){
		if(other == null) return;

		/* --------------------------------- */
		/* TODO: IMPLEMENT THIS METHOD */
		/* --------------------------------- */

		/*
			1. create a dummy state
			2. epsilon transition to start state of current nfa and other
			3. set dummy state to start state
		 */
		int dummy_state = addState(); // creates dummy node

		// add the nodes from the other NFA to this NFA
		this.states.addAll(other.states);
		Integer other_start_state = other.getStartState();

		// add transitions
		for(QSig node : other.transitions.keySet()) {
			for(Integer end : other.getTransitions(node.q, node.sig)) {
				this.addTransition(node.q, node.sig, end);
			}
		}

		this.addTransition(dummy_state, 'e', this.getStartState()); // epsilon transition for this dfa
		this.addTransition(dummy_state, 'e', other_start_state); // epsilon transition for this dfa

		this.setStartState(dummy_state); // sets the current dfa start state to the dummy state

		/* --------------------------------- */

	}

	/* Apply the concatenation operator. Concatenates other to THIS machine */
	/* other is NOT altered */
	public void concatenate(NFA other){
		if(other == null) return;

		/* --------------------------------- */
		/* TODO: IMPLEMENT THIS METHOD */
		/* --------------------------------- */

		/*
			1. get other start node
			2. add all nodes from other to this
			3. do transitions
			4. set start node
			5. clear this final states
			6. set final state of other to this
		 */
		// transition all final nodes of s to start node of other
		//get start
		// add the states from the other NFA to this NFA

		Integer other_start_state = other.getStartState(); // grabs the start state of the other nfa

		// add all states and transitions from other to s
		this.states.addAll(other.states);

		// add transitions
		for(QSig node : other.transitions.keySet()) {
			for(Integer end : other.getTransitions(node.q, node.sig)) {
				this.addTransition(node.q, node.sig, end);
			}
		}

		//add epsilon transitions from all final states of s nfa to "other_start_node"
		for(Integer node : this.finalStates) {
			this.addTransition(node, 'e', other_start_state);
		}

		this.clearFinalStates(); // clear final states

		for(Integer i : other.finalStates) { //set other final states as this final state
			this.finalStates.add(i);
		}

		/* --------------------------------- */

	}


	/*
	 * Use this to print out the machine if you want
	 * Pretty useful for debugging problems
	 */
	public String toString(){
		String out = "States: (";
		for(int state : states){
			out += state + ", ";
		}
		out += ")\n";

		out += "Start: " + startState + "\n";
		out += "Final States:\n";
		for(int state : finalStates){
			out += state + ", ";
		}
		out += "\n";

		for(QSig transition : transitions.keySet()){
			out += transition + " --> " + transitions.get(transition) + "\n";
		}

		return out;
	}


}