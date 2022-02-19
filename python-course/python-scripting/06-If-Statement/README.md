### Exercise 1
```py
a = 6
b = 5
if a < b:
    print("a is less than to b")
else:
    print("a is grater b")

# Output
a is grater b
```

### Exercise 2
```py
c = 8
d = 7
if c < d:
    print("c is less than d")
elif c == d:
    print("c is equal to d")
else:
    print("c is geater than d")

# Output
c is geater than d
```

### Exercise 3
```py
a = 6
b = 4
if a < b:
    print("a is less than b")
    print("a is definntel less than b")
elif a == b:
    print("a is equal to b")
    print("a is definitely equal to b")
else:
    print("a is greater than b")
    print("a is definitely greater than b")

# Output
a is greater than b
a is definitely greater than b
```

### Exercise
```py
a = 5
b = 5
if a < b:
    print("GOOD")
elif a == b:
    print("BAD")
    print("this product is not good")
    print("we need to change it")
else:
    print("VERY GOOG")

# Output
BAD
this product is not good
we need to change it
```

### Exercise
```py
a = 5
b = 5
if a < b:
    print("a is less than b")
else:
    if a == b:
        print("a is equal to b")
    else:
        print("a is greater than b")

OR
a = 5
b = 5
if a < b or a == b:
    print("true")
else:
	print("false")


# Output
a is equal to b
true
```

### Exercise
```py
# else statement
x = 8
y = 4
if x < y:
    print (x)
    print("x is less than y")
    print("x is definitely less than y")
elif x == y:
        print("x is equal to y")
else:
    print (y)
    print("x is greater than y")
    print("x is definitly greater than y")

# Output
4
x is greater than y
x is definitly greater than y
```

## Practice with conditional statement
Read a number between 1-10 and display it in words

### Example 1
```py
import sys

def num():
    num=eval(input("Enter a number between 1-10: "))
    if num == 1:
        print("One")
        sys.exit()
    elif num == 2:
        print("Two")
        sys.exit()
    elif num == 3:
        print("Three")
        sys.exit()
    elif num == 4:
        print("Four")
        sys.exit()
    elif num == 5:
        print("Five")
        sys.exit()
    elif num == 6:
        print("Six")
        sys.exit()
    if num == 7:
        print("Seven")
        sys.exit()
    elif num == 8:
        print("Eight")
        sys.exit()
    elif num == 9:
        print("Nine")
        sys.exit()
    elif num == 10:
        print("Ten")
        sys.exit()
    else:
        print("Invalid number")
        sys.exit()
num()
```

### Example 2
```py
def num():
    num=eval(input("Enter a number between 1-10: "))
    if num == 1:
        print("One")
    elif num == 2:
        print("Two")
    elif num == 3:
        print("Three")
    elif num == 4:
        print("Four")
    elif num == 5:
        print("Five")
    elif num == 6:
        print("Six")
    elif num == 7:
        print("Seven")
    elif num == 8:
        print("Eight")
    elif num == 9:
        print("Nine")
    elif num == 10:
        print("Ten")
    elif num not in [1,2,3,4,5,6,7,8,9,10]:
        print("Your number is out of range. Please select between 1-10")
num()
```

### Example 3
```py
def num():
    num=eval(input("Enter a number between 1-10: "))
    if num == 1:
        print("One")
    if num == 2:
        print("Two")
    if num == 3:
        print("Three")
    if num == 4:
        print("Four")
    if num == 5:
        print("Five")
    if num == 6:
        print("Six")
    if num == 7:
        print("Seven")
    if num == 8:
        print("Eight")
    if num == 9:
        print("Nine")
    if num == 10:
        print("Ten")
    if num not in [1,2,3,4,5,6,7,8,9,10]:
        print("Your number is out of range. Please select between 1-10")
num()
```


### Example 4 (Better soulution)
```py
def num():

    num=eval(input("Enter a number between 1-10: "))
    if num in  [1,2,3,4,5,6,7,8,9,10]:
        if num == 1:
            print("One")
        elif num == 2:
            print("Two")
        elif num == 3:
            print("Three")
        elif num == 4:
            print("Four")
        elif num == 5:
            print("Five")
        elif num == 6:
            print("Six")
        elif num == 7:
            print("Seven")
        elif num == 8:
            print("Eight")
        elif num == 9:
            print("Nine")
        elif num == 10:
            print("Ten")
    else:
        print("Your number is out of range. Please select between 1-10")

num()


### Example 4 (much better soulution)
```py
def num():

    num=eval(input("Enter a number between 1-10: "))
    if num in  [1,2,3,4,5,6,7,8,9,10]:
        if num == 1:
            print("One")
        elif num == 2:
            print("Two")
        elif num == 3:
            print("Three")
        elif num == 4:
            print("Four")
        elif num == 5:
            print("Five")
        elif num == 6:
            print("Six")
        elif num == 7:
            print("Seven")
        elif num == 8:
            print("Eight")
        elif num == 9:
            print("Nine")
        else:
            print("Ten")
    else:
        print("Your number is out of range. Please select between 1-10")

num()
```

### Example 4 (perfait soulution)
```py
def num_function():

    num=eval(input("Enter a number between 1-10: "))
    num_word={1:'One',2:'Two',3:'Three',4:'Four',5:'Five',6:'Six',7:'Seven',8:'Eight',9:'Nine',10:'Ten'}

    if num in [1,2,3,4,5,6,7,8,9,10]:
       print(num_word.get(num))
    else:
        print("Your number is out of range. Please select between 1-10")

num_function()
```

### Example 5
```py
marks = 65.6
if marks < 59.99:
    print("Failed")
elif marks == 60 or marks <= 69.99:
    print("D Grade")
elif marks == 70 or marks <= 79.99:
    print("C Grade")
elif marks == 80 or marks <= 89.99:
    print("B Grade")
elif marks == 80 or marks <= 100:
    print("A Grade")
else:
    print("Invalid input")


marks = 101
if marks < 59.99 and marks >= 0:
    print("Failed")
elif marks == 60 or marks <= 69.99:
    print("D Grade")
elif marks == 70 or marks <= 79.99:
    print("C Grade")
elif marks == 80 or marks <= 89.99:
    print("B Grade")
elif marks == 80 or marks <= 100:
    print("A Grade")
else:
    print("Invalid input")


marks = 81
if marks < 59.99 and marks >= 0:
    print("Failed")
elif marks > 59.99 and marks <= 69.99:
    print("D Grade")
elif marks <= 70 and marks <= 79.99:
    print("C Grade")
elif marks <= 80 or marks <= 89.99:
    print("B Grade")
elif marks <= 80 or marks <= 100:
    print("A Grade")
else:
    print("Invalid input")
```

### Python if statement

```py
if condition:
   statements-1
   statements-2
statements-3
```

```py
#!/usr/bin/env python3

import sys

# Only integers allowed
try:
    num = int(input("Enter any number: "))
except:
    print("Only numbers allowed")
    sys.exit(1)

# if block condition
if num > 5:
    # if block starts, notice the indentation
    print("You have entered the if block")
    print("The provided number is greater than 5")
    print("Exiting if block")

# if block ends, notice the indentation
print("Now we are in main function")
```

```py
import sys

# Only strings allowed

FIRST_NAME = str(input("Enter your first name: "))
LAST_NAME = str(input("Enter your last name: "))

# if block condition
if FIRST_NAME == "Tia":
    print(f"Welcome {FIRST_NAME} {LAST_NAME}!")
elif FIRST_NAME == "tia":
    print(f"Welcome {FIRST_NAME} {LAST_NAME}!")
else:
    print(f"Hummmmmm")
```

### Python if..else statement
```py
if condition:
   statements-1
else:
   statements-2
```

```py

import sys

# Only integers allowed
try:
    num = int(input("Enter any number: "))
except:
    print("Only numbers allowed")
    sys.exit(1)

# if block condition
if num > 5:
    # if block starts, notice the indentation
    print("You have entered the if block")
    print("The provided number is greater than 5")
    print("Exiting if block")
# else block
else:
    # else block starts, notice the indentation
    print("You have entered the else block")
    print("The provided number is less than 5")
    print("Exiting else block")

# if..else block ends, notice the indentation
print("Now we are in main function")
```

### Python if..elif..else statement
```py
if condition-1:
    sequence of statements-1
elif condition-n:
    sequence of statements-n
else:
    default sequence of statements
```

```py
#!/usr/bin/env python3

import sys

# Only integers allowed
try:
    num = int(input("Enter any number: "))
except:
    print("Only numbers allowed")
    sys.exit(1)

# if block condition
if num > 5:
    # if block starts, notice the indentation
    print("You have entered the if block")
    print("The provided number is greater than 5")
    print("Exiting if block")
elif num == 5:
    # elif block starts, notice the indentation
    print("You have entered the elif block")
    print("The provided number is equal to 5")
    print("Exiting elif block")
else:
    # else block starts, notice the indentation
    print("You have entered the else block")
    print("The provided number is less than 5")
    print("Exiting else block")

# if..elif..else block ends, notice the indentation
print("Now we are in main function")
```

### Python Nested if statement
```py
#!/usr/bin/env python3

import sys

# Only integers allowed
try:
    num = int(input("Enter any number: "))
except:
    print("Only numbers allowed")
    sys.exit(1)

# if block condition
if num > 5:
    # if block starts, notice the indentation
    print("You have entered the if block")
    print("The provided number is greater than 5")
    print("Exiting if block")
elif num == 5:
    # elif block starts, notice the indentation
    print("You have entered the elif block")
    print("The provided number is equal to 5")
    print("Exiting elif block")
else:
    # else block starts, notice the indentation
    print("You have entered the else block")
    if num == 1:
        # nested if block starts, notice the indentation
        print("You have entered into nested if block")
        print("The provided number is equal to 1")
        print("Exiting nested if block")
    elif num == 2:
        # nested if..elif block starts, notice the indentation
        print("You have entered into nested if..elif block")
        print("The provided number is equal to 2")
        print("Exiting nested if..elif block")
    else:
        # nested if..elif..else block continues, notice the indentation
        print("The provided number is less than 5")
        print("Exiting nested if..elif..else block")

# if..elif..else block ends, notice the indentation
print("Now we are in main function")
```

### Python Nested If Example
Syntax
```py
if expression1:
   statement(s)
   if expression2:
      statement(s)
   elif expression3:
      statement(s)
   elif expression4:
      statement(s)
   else:
      statement(s)
else:
   statement(s)
```


```py 
#!/usr/bin/env python3
age = int(input(" Please Enter Your Age Here:  "))
if age < 18:
    print(" You are Minor ") 
    print(" You are not Eligible to Work ") 
else:
    if age >= 18 and age <= 60:
        print(" You are Eligible to Work ")
        print(" Please fill in your details and apply")
    else:
        print(" You are too old to work as per the Government rules")
        print(" Please Collect your pension!")
```

```py
#!/usr/bin/python

var = 100
if var < 200:
   print "Expression value is less than 200"
   if var == 150:
      print "Which is 150"
   elif var == 100:
      print "Which is 100"
   elif var == 50:
      print "Which is 50"
   elif var < 50:
      print "Expression value is less than 50"
else:
   print "Could not find true expression"

print "Good bye!"
```

## Python logical operator with if condition
In the `if` condition, you can define multiple conditions using python logical operators. Use logical `and`, `or`, `not `operator in your python scripts to define multiple condition. These operators can be used with if or elif condition

In all the syntax I shared above, replace condition with

- For `and` operator: condition-1 and condition-2
- For `or` operator: condition-1 or condition-2
- For `not `operator: not condition

### Example-1
```py
#!/usr/bin/env python3

import sys

# Only integers allowed
try:
    num = int(input("Enter any number: "))
except:
    print("Only numbers allowed")
    sys.exit(1)

# if block condition
if num > 5 and num < 10:
    # if block starts, notice the indentation
    print("You have entered the if block")
    print("The provided number is greater than 5 and less than 10")
    print("Exiting if block")
elif num == 4 or num == 5:
    # elif block starts, notice the indentation
    print("You have entered the elif block")
    print("The provided number is equal to 4 or 5")
    print("Exiting elif block")
else:
    # else block starts, notice the indentation
    print("You have entered the else block")
    print("The provided number is less than 5")
    print("Exiting else block")

# if..elif..else block ends, notice the indentation
print("Now we are in main function")
```
