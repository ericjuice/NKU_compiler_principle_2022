in2sf: infix_2_sffix.y
	bison -d infix_2_sffix.y
	gcc infix_2_sffix.tab.c -o in2sf
	echo "success\n"
	
calc: calc1.y
	bison -d calc1.y
	gcc calc1.tab.c -o calc1
	echo "success\n"

clean: 
	rm in2sf
	rm *.tab.c *.tab.h

arm:
	arm-linux-gnueabihf-gcc -o add_arm.s -S -O0 add.c -fno-asynchronous-unwind-tables

arm2ex:
	arm-linux-gnueabihf-gcc add_arm.s -o add_arm -static

v:
	arm-linux-gnueabihf-gcc add.s -o add_arm -static
	./add_arm

test:
	arm-linux-gnueabihf-gcc -o add_armtest.s -S -O0 addtest.c -fno-asynchronous-unwind-tables
