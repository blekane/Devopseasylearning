# Makefiles
- Learn Makefiles [here](https://makefiletutorial.com/#getting-started)


## Install make 
```
yum install make -y
apt install make -y
brew install make
```

## notes
- --user $$(id -u) --group $$(id -g) `$$` = run as shell command instead of make 
	- -docker container rm $$(docker ps -aq) -f
	- -docker container rm $(shell docker ps -aq) -f ---> you can use `shell` if you don't want to use `$$`
	- $$(cat /etc/passwd |tail -1 |grep -o bin) or $(shell cat /etc/passwd |tail -1 |grep -o bin)


## Makefile Syntax
A Makefile consists of a set of rules. A rule generally looks like this:
```Makefile
targets: prerequisites
   command
   command
   command
```

## Example
- blah requires blah.o, so make searches for the blah.o target
- blah.o requires blah.c, so make searches for the blah.c target
- blah.c has no dependencies, so the echo command is run

```Makefile
blah: blah.o
	cc blah.o -o blah # Runs third

blah.o: blah.c
	cc -c blah.c -o blah.o # Runs second

blah.c:
	echo "int main() { return 0; }" > blah.c # Runs first
```

RESULT
```
echo "int main() { return 0; }" > blah.c # Runs first
cc -c blah.c -o blah.o # Runs second
cc blah.o -o blah # Runs third
```

## Variables
Variables can only be strings. Here's an example of using them:

**Variables definition:**

```Makefile
var0 := ubuntu
var1 = docker
var2 := pull
var3 := $(var1) $(var2)
var4 := $(var3) $(var0)

pull_ubuntu:
	$(var4)


var0 := ubuntu
var1 = docker
var2 := pull
var3 := $(var1) $(var2)
var4 := $(var3) $(var0)

pull_ubuntu:
	$(var4)
	$(var1) images
	$(var1) run -it $(var0):latest sh
clean:
	-docker container rm $$(docker ps -aq) -f
	-docker rmi $$(docker images -aq) -f
	-docker images
	-docker ps -a

clean02:
	-docker container rm $(shell docker ps -aq) -f 
	-docker rmi `docker images -q -f dangling=true`
```

```Makefile
## some_file depend on file1 file2 which means file1 file2 will run first
files = file1 file2
some_file: $(files)
	echo "Look at this variable: " $(files)
	touch some_file

file1:
	touch file1
file2:
	touch file2

clean:
	rm -f file1 file2 some_file

----------------------------------------------------
## some_file depend on file1 file2 which means file1 file2 will run first
files = var1
some_file: file1 file2
	echo "Look at this variable: " $(files)
	touch file3
	ls -l
	docker ps

file1:
	touch file1
file2:
	touch file2

clean:
	rm -f file1 file2 file3

----------------------------------------------------
## Only some_file will run because make will run the first element
files = file1 file2
some_file:
	echo "Look at this variable: " $(files)
	touch file3

file1:
	touch file1
file2:
	touch file2

clean:
	rm -f file1 file2 file3 
```

## Example
Here, the target some_file "depends" on other_file. When we run make

```Makefile
some_file: other_file
	echo "This will run second, because it depends on other_file"
	touch some_file

other_file:
	echo "This will run first"
	touch other_files
```

## Reference variables using (} or $()
```Makefile
x = dude

all:
	echo "Good practice"
	echo $(x)
	echo (x}

	echo "Bad practice, but works"
	echo $x
```

## The all target
Making multiple targets and you want all of them to run? Make an all target.

```Makefile
all: one two three

one:
	touch one
two:
	touch two
three:
	touch three

clean:
	rm -f one two three
```

## Multiple targets
When there are multiple targets for a rule, the commands will be run for each target
`$@` is an automatic variable that contains the target name.

```Makefile
all: f1.o f2.o

f1.o f2.o:
	echo $@

##Equivalent to:
f1.o
    echo $@
f2.o
    echo $@
----------------------------------------------------
# $< this print the first argument after the column which is `one`
# $? or $? print all the arguments after the column which is `one two`
# $@ print all the arguments before the  the column which is `hey`

hey: one two
    # Outputs "hey", since this is the first target
	echo $@
    # Outputs "one two", since this is the second target
	echo $?
    # Outputs "one two", since this is the second target
	echo $^
	touch hey
one:
	touch one
two:
	touch two
clean:
	rm -f hey one two

----------------------------------------------------
# $< this print the first argument after the column which is `one`
# $? or $? print all the arguments after the column which is `one two`
# $@ print all the arguments before the  the column which is `hey`
hey: one two
	@echo $@
	@echo $?
	@echo $^
	@echo $<
	@touch hey
one:
	touch one
two:
	touch two
clean:
	rm -f hey one two

----------------------------------------------------
## Use @ infro of the shell command if you don't want to see the command at run time
hey: one
	@echo "This is the first target is $@ and the second target is $? or $^"
	@echo $?
	@echo $^
	@touch three
one:
	@touch one
	@touch two
clean:
	rm -f one two three
----------------------------------------------------

hey: touch_file
	@echo "This is the first target is $@ and the second target is $? or $^"
	@echo $?
	@echo $^
	@touch three
touch_file:
	@touch one
	@touch two
clean:
	rm -f one two three
----------------------------------------------------

hey: one
	@echo "This is the first target is $@ and the second target is $? or $^"
	@echo "This is version $^ and the second version is $@"
	touch hey_$@
	touch hey_$?
	@ls -@l
	@docker images
	@docker ps -a
one:
	touch two
	touch three
clean:
	@rm -f one two hey hey_hey hey_one three six || tree
```

# Automatic Variables and Wildcards
Both `*` and `%` are called wildcards in Make, but they mean entirely different things. `*` searches your filesystem for matching filenames. 
## Wildcard

```Makefile
# Print out file information about every .c file
print01: *.c
	ls -la  $?
# Print out file information about every .o file
print02: *.o
	ls -la  $?
# Print out file information about every .md file
print03: *.md
	ls -la  $?

----------------------------------------------------
all: print01 print02 print03

print01: *.c 
	ls -la  $?
print02: *.o
	ls -la  $?
print03: *.md
	ls -la  $?
----------------------------------------------------

all: print01 print02 print03
	@echo $@
	@echo $?
	@echo $<
print01: *.c 
	@ls -la  $?
print02: *.o
	@ls -la  $?
print03: *.md
	@ls -la  $?
----------------------------------------------------

objects := foo.o bar.c all.txt var.blah all2.txt
all: files

# These files compile via implicit rules
files: 
	touch $(objects)

clean:
	rm -f *.c *.o *.txt *.blah 
```

## % Wildcard










## Command Echoing/Silencing
Add an `@` before a command to stop it from being printed. You can also run make with `-s` to add an @ before each line
```Makefile
all: 
    @echo "This make line will not be printed"
    echo "But this will"
```

## Command Execution
Each command is run in a new shell.

```Makefile
all: 
	cd ..
    # The cd above does not affect this line, because each command is effectively run in a new shell
	echo `pwd`

    # This cd command affects the next because they are on the same line
	cd .. && echo `pwd`

    # Same as above
	cd ..; \
	echo `pwd`

	cd ~ && pwd
	pwd

	cd ~; \
	ls; \
	ls -l; \
	ls -a; \
	touch file1 hr manager vpc && ls; \
	pwd 
	pwd

clean: 
	cd ~; \
	rm -rf file1; \
	rm -rf hr; \
	rm -rf manager; \
	rm -rf vpc; \
	ls
	ls
```

## Default Shell
The default shell is `/bin/sh`. You can change this by changing the variable SHELL:
```Makefile
SHELL=/bin/bash

cool:
    echo "Hello from bash"
```

## Conditional part of Makefiles (if/else)
ifeq: if equal
ifneq: if not equal

```Makefile
#Conditional if/else
foo = ok

all:
ifeq ($(foo), ok)
	echo "foo equals ok"
else
	echo "nope"
endif
----------------------------------------------------
#Check if a variable is defined
bar =
foo = $(bar)

all:
ifdef foo
	echo "foo is defined"
endif
ifdef bar
	echo "but bar is not"
endif
----------------------------------------------------

# VARIABLE AS SHELL COMMAND
SCRS1 := $(shell pwd)
SCRS2 := $(shell cat /etc/passwd |tail -1 |grep -o bin)

all:
	@echo $(SCRS1)
	@echo $(SCRS2)

ifeq ($(SCRS2), bin)
	@echo "YES. I WAS TO GREP $(SCRS2)"
else
	@echo "I WAS NOT ABLE TO GREP $(SCRS2) "
endif
----------------------------------------------------
SCRS1 := $$(pwd)
SCRS2 := $$(cat /etc/passwd |tail -1 |grep -o bin)

all:
	@echo $(SCRS1)
	@echo $(SCRS2)

ifeq ($(SCRS2), bin)
	@echo "YES. I WAS TO GREP $(SCRS2)"
else
	@echo "I WAS NOT ABLE TO GREP $(SCRS2) "
endif
```



```Makefile


build:
	docker build -t devopseasylearning2021/tia:static-website-example2 .

push:
	docker push devopseasylearning2021/tia:static-website-example2

run:
	docker run --name static-website-example2 -p 8021:80 -d devopseasylearning2021/tia:static-website-example2
	

build:
        docker build -t devopseasylearning2021/tia:static-website-example2 .

push:
        docker push devopseasylearning2021/tia:static-website-example2

run:
        docker run --name static-website-example2 -p 8021:80 -d devopseasylearning2021/tia:static-website-example2
