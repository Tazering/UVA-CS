# goal definition: defines the module to be build (hello.o) 
# *obj-m* defines loadable module goal; *obj-y* defines built-in object goal
obj-m+=ebbchar.o

# *$(shell uname -r)*: display current kernel version
# *-C* switches current directory to kernel directory
all:
	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) modules
	$(CC) testebbchar.c -o test
clean:
	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) clean
	rm test
