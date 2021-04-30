## Python Scripting 

###  Introduction to Functions
**Function:**
- A function is a block of code for some specific operation.
- Function code is re-usable.
- A function executes only when it is called.

```py
import os
import time
import platform
def mycode(cmd1,cmd2):
	print("Please wait. Cleaning the screen....")
	time.sleep(2)
	os.system(cmd1)
	print("Please wait finding the list of dir and files")
	time.sleep(2)
	os.system(cmd2)
if platform.system()=="Windows":
	mycode("cls","dir")
else:
	mycode('clear','ls -lrt')

```

### How to define a Function and How to usedefined Funtion , Types of Functions
**Function:**
- A function is a block of code for some specific operation.
- Function code is re-usable.
- It will execute only when it is called.

**Why Function are used ?**
- Code Reusability
- Improve Modularity

**Types of Functions:**
Basically, we can divide functions into the following two types:
- Built-in Functions: Functions that are built into Python.
- User-Defined Functions: Functions defined by the users themselves


### Rules to define function name:
- Function name should have only a-z,A-Z,0-9, _
- Function shuold not start with number but can it be start with _
- Dont include any space.
- Function must be define befor calling it

```py
def display():
	print("Welcome to functions concept")
	print("Simple way to define your function")
	return None

display()


print(len("hi"))
x=40
print(id(x))


x=(5,6)
print(len(x))

print(min(x))
print(max(x))

#Output
2
5
6
```

### Converting simple code into Functions
```py
print("Welcome to Python Scripting")
print("Python is easy to learn")
print("Now we are good with bascis")
print("We are about to start functions concepts in python")
print("Function are very easy in python")
print("Now we are writing simple functions")

def welcome_msg():
	print("Welcome to Python Scripting")
	print("Python is easy to learn")
	return None
def known_concepts():
	print("Now we are good with bascis")
	print("We are about to start functions concepts in python")
	return None
def learning_concepts():
	print("Function are very easy in python")
	print("Now we are writing simple functions")
	return None
welcome_msg()
known_concepts()
learning_concepts()
```

### Calling a function from another function and Scope of the variables

```py
def myfunction1():
    print("x value from fun1: ",x)
    return None

def myfunction2(): 
    print("x value from fun2: ",x)
    return None

def main():
	global x
	x=10 
	myfunction1()
	myfunction2()  
	return None
    
main()
```


### Simple Functions with arguments
```py

def get_result(): 
    num=eval(input("Enter your number: "))
    result=num+10
    print(f'Your result is: {result}')
    return None
get_result()

#---------------------------------------------------------------

def get_result():
    result=num+10
    print(f'Your result is: {result}')
    return None

def main():
    global num
    num=eval(input("Enter your number: "))
    get_result()
    return None

main()

#---------------------------------------------------------------

global num
num=eval(input("Enter your number: "))

def get_result():
    result=num+10
    print(f'Your result is: {result}')
    return None

def main():
    get_result()
    return None

main()
  
#---------------------------------------------------------------

num=eval(input("Enter your number: "))

def get_result():
    result=num+10
    print(f'Your result is: {result}')
    return None

def main():
    get_result()
    return None

main()

#---------------------------------------------------------------

def get_add(p,q):
	aresult=p+q
	print(f'The addition of {p} and {q} is: {aresult}')
	return None
def get_sub(m,n):
	sresult=m-n
	print(f'The sub of {m} and {n} is: {sresult}')
	return None

def main():
	a=eval(input("Enter your first num: "))
	b=eval(input("Enter your second num: "))
	get_add(a,b)
	get_sub(a,b)
	x=50
	get_sub(19,x)
	return None

main()

#---------------------------------------------------------------

def get_add(p,q):
	aresult=p+q
	print(f'The addition of {p} and {q} is: {aresult}')
	return None
def get_sub(m,n):
	sresult=m-n
	print(f'The sub of {m} and {n} is: {sresult}')
	return None

def main():
	a=10
	b=4
	get_add(a,b)
	get_sub(a,b)
	return None

main()

#---------------------------------------------------------------

a=10
b=4

def get_add(p,q):
    aresult=p+q
    print(f'The addition of {p} and {q} is: {aresult}')
    return None
def get_sub(m,n):
	sresult=m-n
	print(f'The sub of {m} and {n} is: {sresult}')
	return None

def main():
	get_add(a,b)
	get_sub(a,b)
	return None

main()
```

### Functions with default arguments
```py

def display(a=1):
	print("The value of a is: ",a)
	return None

display(4)
display(5)
display()

#Output
The value of a is:  4
The value of a is:  5
The value of a is:  1

#---------------------------------------------------------------

def add_numbers(a,b=0):
	result=a+b
	print("The result is: ",result)
	return None
add_numbers(4,5)
add_numbers(5)
add_numbers(7)

#Output
The result is:  9
The result is:  5
The result is:  7

#---------------------------------------------------------------

def working_on_some(user="root"):
    print(f"working with {user}")
    return None

working_on_some("db_admin")

#Output
working with db_admin

#---------------------------------------------------------------

def working_on_some(user="root"):
    print(f"working with {user}")
    return None

working_on_some("db_admin")

#Output
working with db_admin

#---------------------------------------------------------------

def working_on_some(user="root"):
    print(f"working with {user}")
    return None

working_on_some()

#Output
working with root
```

