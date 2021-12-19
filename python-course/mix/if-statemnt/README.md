
```py
a = 6
b = 5
if a < b:
    print("a is less than to b")
else:
    print("a is grater b")


c = 8
d = 7
if c < d:
    print("c is less than d")
elif c == d:
    print("c is equal to d")
else:
    print("c is grater than d")


a = 6
b = 4
if a < b:
    print("a is less than b")
    print("a is definitely less than b")
elif a == b:
    print("a is equal to b")
    print("a is definitely equal to b")
else:
    print("a is greater than b")
    print("a is definitely greater than b")


a = 5
b = 5
if a < b:
    print("GOOD")
elif a == b:
    print("BAD")
    print("this product is not good")
    print("we need to change it")
else:
    print("VERY GOOD")


# else statement
x = 8
y = 4
if x < y:
    print(x)
    print("x is less than y")
    print("x is definitely less than y")
elif x == y:
    print("x is equal to y")
else:
    print(y)
    print("x is greater than y")
    print("x is definitely greater than y")


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
