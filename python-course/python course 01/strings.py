print("Today is a good day to learn Python")
print('Python is fun')
print("Python's string are easy to use")
print('We can even include "quotes" in strings')
print("hello" + " world")
greeting = "Hello"
name = input("Please enter your name: ")
print(greeting + name)
# if we want a space, we can add that too
print(greeting + ' ' + name)
print(f"{greeting} {name}")


GREETING1 = """
Today is a good day to learn Python
Python is fun
Python's string are easy to use
We can even include "quotes" in strings
hello world
"""
print(GREETING1)

GREETING = "Hello"
NAME = input("Please enter your name: ")

# if we want a space, we can add that too
print(f"{GREETING} {NAME}")
print(f"{GREETING.upper()} {NAME.upper()}")
print(f"{GREETING.lower()} {NAME.lower()}")
