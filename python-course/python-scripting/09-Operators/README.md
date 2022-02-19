## Operators in Python
- **Python Logical Operators with Examples:**  https://www.geeksforgeeks.org/python-logical-operators-with-examples-improvement-needed/

### Operators:
- Operators are the pillars for any language.
- The operator can be defined as a symbol which is responsible for a particular operation between two operands.
- Example ‘+’ is an operators , to perform addition operation on operands.
- Operands may be values or variables or combination of values and variables.
- Python provides a variety of operators described as follows.
    - Arithmetic Operators
    - Assignment Operators
    - Comparison Operators
    - Identity Operators
    - Membership Operators
    - Logical Operators
    - Bitwise Operators

### Comparison Operators
== (Equal to Operator)
!= (Not Equal to Operator)
< (Less than Operator)
> (Greater than Operator)
<= (Less than or Equal to Operator)
>= (Greater than or Equal to Operator)
is (is Operator)

```py
Equal: 3 == 2
Not equal: 3 != 2
Greater than: 3 > 2
Less than: 3 < 2
Greater or equal: 3 >= 2
Less than or equal: 3 <= 2
```

```py
#!/usr/local/bin/python3
a=3
b=5
result=a+b
print(f"The addition of {a} and {b} is {result}")
```

```py
#!/usr/local/bin/python3
a=eval(input("Enter your first number: "))
b=eval(input("Enter your second number: "))
result=a+b
print(f"The addition of {a} and {b} is {result}")
```


### Copmarisons with if statement
```py
x = 8
y = 6
if x < y:
    print("True")
    print('x is less than y')
else:
    print("False")


if x > y:
    print("True")
    print('x is greater than y')
else:
    print("False")


if x <= y:
    print("True")
    print('x is less or equal y')
else:
    print("False")


if x != y:
    print("True")
    print('x is not equal to y')
else:
    print("False")


if x == y:
    print("True")
    print('x is equal to y')
else:
    print("False")
```


### Arithmetic operation
- Addition: 3 + 2
- soustraction: 3 - 2
- mutliplcation: 3 * 2
- Division: 3 / 2
- Floor division: 3 // 2 :(if you do not want the remainder of the division)
- Exponent: 3 ** 2
- Modulor: 3 % 2 :(if you want to know the remainder of 18/4, type 3 % 2)

- Addition +
- Subtraction -
- Multiplication *
- Division /
- Modulo %
- Floor division //
- Exponential

```py
print(3+2)
print(3-2)
print(3*2)
print(3/2)
print(3//2)
print(3**2)
print(3%2)

#Output
5
1
6
1.5
1
9
1
```

### Absolute value and round
```py
print(abs(-3))
# this means no decimal.
print(round(3.75))
print(round(3.45))
# this means round to the firs digit after the decimal.
print(round(3.75, 1))
print(round(3.75, 10))

#Output
3
4
3
3.8
3.75
```

### Variables incrementation
```py
num = 1
a = 5
a = a + 1
num += 1
print(a)
print(num)

#Output
6
2
```

### Identity operators: 
Identity operators are used to find the type of: class/type/object/variable. 
They are two types of Identity operators:
- is
- is not

### Identity operators example in python
```py
#!/usr/local/bin/python3
a=30.2
b=4
c="hello"
d="5.3.4.30"
e="good"
z=[3, 10, -1, 1, 'hello']

print(a,type(a))
print(b,type(b))
print(c,type(c))
print(d,type(d))
print(e,type(e))
print(z,type(e))

print(" ")

print(type(a) is type(b))
print(type(c) is type(d))
print(type(e) is type(d))
print(type(e) is type(a))
print(type(e) is not type(a))

#Output
30.2 <class 'float'>
4 <class 'int'>
hello <class 'str'>
5.3.4.30 <class 'str'>
good <class 'str'>
[3, 10, -1, 1, 'hello'] <class 'str'>

False
True
True
False
True
```
 
### Membership operators: 
Membership operators are used to validate the membership of a value. They are two types of Membership operators:
- in
- not in

```py
z=[3, 10, -1, 1, 'hello']
print(3 in z)
print(5 not in z)
print( 'hello' in z)
print( 0 in z)

#Output
True
True
True
False
```

```py
z=[3, 10, -1, 1, 'hello']
if 3 in z:
    print("OK")
else:
    print("Bad")

#Output
OK
```

```py
JAVA_VERSION=['1.6', '1.7', '1.8', '1.9']
HOST_JAVA_VERSION='1.5'
if HOST_JAVA_VERSION in JAVA_VERSION:
    print("The JAVA version is correct")
else:
    print("The JAVA version is incorrect")

#Output
OK
The JAVA version is incorrect
```

```py
JAVA_VERSION=['1.6', '1.7', '1.8', '1.9']
HOST_JAVA_VERSION='1.5'
if HOST_JAVA_VERSION in JAVA_VERSION:
    print("The JAVA version is correct")
else:
    print("The JAVA version is incorrect")

import subprocess
KERNEL_VERSION="uname -a".split()
KERNEL_VERSION_SP=subprocess.Popen(KERNEL_VERSION,shell=False,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
KERNEL_VERSION_RC=KERNEL_VERSION_SP.wait()
KERNEL_VERSION_OUTPUT,KERNEL_VERSION_ERROR=KERNEL_VERSION_SP.communicate()
VALID_VERSION=['4', '2', '5', '6']
RESULT=KERNEL_VERSION_OUTPUT.split()[2].split("-")[0].split(".")[0]

if RESULT in VALID_VERSION:
    print("Kernel verssion check passed")
else:
    print("Kernel verssion check failed")
```

### Check if a user is a valid user to start and application
```py
db_users=['db_admin', 'db_config', 'db_installation']
random_user='db_admin'
if random_user in db_users:
    print("This user is allowd to start db")
else:
    print("This user is not allowd to start db")


db_users=['db_admin', 'db_config', 'db_installation']
random_user='db_admin'
if random_user not in db_users:
    print("This user not is allowd to start db")
elif  random_user in db_users:
    print("This user is not allowd to start db")
else:
    print("invalid")
```

### Logical operators: 
Logical operators are useful to combine multiple conditions. They are three type of logical operators in python. They are:
- and (all the condition most be true so that the answer can be true)
- or (at least one mot be true)
- not

### Logical AND operator
Logical operator returns True if both the operands are True else it returns False.
```py
a = 10
b = 10
c = -10
  
if a > 0 and b > 0: 
    print("The numbers are greater than 0") 
  
if a > 0 and b > 0 and c > 0: 
    print("The numbers are greater than 0") 
else: 
    print("Atleast one number is not greater than 0") 
```

### Logical or operator
Logical or operator returns True if either of the operands is True.
```py
a = 10
b = -10
c = 0
  
if a > 0 or b > 0: 
    print("Either of the number is greater than 0") 
else: 
    print("No number is greater than 0") 
  
if b > 0 or c > 0: 
    print("Either of the number is greater than 0") 
else: 
    print("No number is greater than 0") 


a = 10
b = 12
c = 0
  
if a or b or c: 
    print("Atleast one number has boolean value as True") 
else: 
    print("All the numbers have boolean value as False") 
```

## Logical not operator
Logical not operator work with the single boolean value. If the boolean value is True it returns False and vice-versa
```py
a = 10
  
if not a: 
    print("Boolean value of a is True") 
  
if not (a%3 == 0 or a%5 == 0): 
    print("10 is not divisible by either 3 or 5") 
else: 
    print("10 is divisible by either 3 or 5") 
```