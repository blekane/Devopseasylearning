
### What is variable ?
A variable is nothing but a reserved memory location to store values. In other words a variable in a program gives data to the computer to work on.

### How to declare and use a variable?
No need to declare variables type before using them because python will automatically determine the type of variable
a = 10
print(a)
Note: Don’t write quotes around the variable name.

```py
# This will print value stored inside the variable
a = 10
print(a)

# Output
10
```

```py
# This will print the variable and not the value stored inside the variable
a = 10
print("a")

OR
a = 10
print("a")

# Output
a
```

### Displaying a variable value and type using print
```py
a = 10
b = 4.8
c = "hello"

print(a)
print(type(a))

print(b)
print(type(b))

print(c)
print(type(c))

# Output
10
<class 'int'>
4.8
<class 'float'>
hello
<class 'str'>
```

### Rules to define a variable names
#### 1.It should contains letters, numbers and underscore.
```
my_viriable2 = "java version"
```

#### 2.It should not contains a keyword.
```
if or print = "java version"
```

#### 3.Can’t contain spaces.
```
my viriable 2 = "java version"
```
#### 4.It should not start with a number
```
20_viriable_2 = "java version"
2x = 50
```
#### 5.Case-sensitive

```py
# These 2 different variables
X = 5
x = 10
print(x)
print(X)

# Output
5
10
```

### Data types in Python:
- Every value in Python has a data type.
- Since everything is an object in Python programming, data types are actually classes and variables are instance (object) of these classes. There are various data types in Python. Basic Data Types are:
    1.Numbers( int, float and complex )
    2.Strings
    3.Boolean

### String variable
A string variable must be in quote
```py
lan_name_1="Python Scripting 1"
lan_name_2='Python Scripting 2'
print(lan_name_1)
print(lan_name_2)

# Output
Python Scripting 1
Python Scripting 2
```

### Int and float variable
Int and float variable can be in quote or not
```py
X = "5"
x = '10'
Y = 5.8
y = 10
print(x)
print(X)
print(Y)
print(y)
```
### Boolean Value
Boolean Value must start with capital letter and we do not need quotation
```py
my_value_1=True
my_value_2=False
print(my_value_1)
print(my_value_2)

print(my_value_1,type(my_value_1))
print(my_value_2,type(my_value_2))

# Output
True
False
True <class 'bool'>
False <class 'bool'>
```

### Converting one Data Type to another
We can't convert strings into numbers
```py
x=5
print(x,type(x))

y=str(x)
print(y,type(y))

z=bool(x)
print(z,type(z))

p=float(x)
print(p,type(p))

f=20.85
print(int(f))

# Output
5 <class 'int'>
5 <class 'str'>
True <class 'bool'>
5.0 <class 'float'>
20
```

### Boolean of empty
Boolean of empty is always False
```py
Note: Any data can be convert to boolean
      Boolean of any data type can be True or False
      bool(empty-data) = False ===> bool(0), bool(None), bool([]), bool({}), bool(())
      bool(non-empty-data) = True

x=""
print(bool(x))
print(bool(0))
print(bool(None))
print(bool(()))
print(bool([]))
print(bool({}))

# Output
False
```

### Define a version of a software
Always define a version of a software in quote. Python take as a string and not int
```py
python_version="3.9.0"
print(python_version)
print(python_version,type(python_version))

# Output
3.9.0
3.9.0 <class 'str'>

python_version=3.9.0
print(python_version)
# Output
SyntaxError: invalid syntax
```

### Convert a version of a software into an Int
We can't convert it into an int because it is define as a string
```py
python_version="3.9.0"
print(python_version)
print(python_version,type(python_version))
int(python_version)

# Output
3.9.0
3.9.0 <class 'str'>
ValueError: invalid literal for int() with base 10: '3.9.0'
```

### Working with multiple variable
```py
'''
x=3; y=5.7; lan_name="python scripting"
'''
x = 3
y = 5.7
lan_name = "python scripting"
print(x, y, lan_name)
print("{} {} {}".format(x, y, lan_name))
# \n can be only in quotation
#print("{} \n{} \n{}".format(lan_name,x,y))
print("{} \n{} \n{}".format(x,y,lan_name))
print("\n\t- {} \n\t- {} \n\t- {}".format(x,y,lan_name))

print(f'{x} {y} {lan_name} language version')
print(f'Python {x}.9 is the latest version and I like {lan_name} for automation')


# Output
3 5.7 python scripting
3 5.7 python scripting
3
5.7
python scripting

	- 3
	- 5.7
	- python scripting
3 5.7 python scripting language version
Python 3.9 is the latest version and I like python scripting for automation
```

### Variable concatenation
- **NB:** The print(f".....") is only avaible in python 3 and and 2
```py
x=3
y=5.7
lan_name="python scripting"

print(x,y,lan_name)
print(f"The x value is {x}; the y value is {y} and the language value is {lan_name}.")
print(f"The x value is {x}; \nThe y value is {y} \nThe language value is {lan_name}.")

# Output
3 5.7 python scripting
The x value is 3; the y value is 5.7 and the language value is python scripting.
The x value is 3;
The y value is 5.7
The language value is python scripting.

x=3
y=5.7
lan_name="python scripting"
my_var_output=f"The x value is {x}; \nThe y value is {y} \nThe language value is {lan_name}."
print(my_var_output)

# Output
The x value is 3;
The y value is 5.7
The language value is python scripting.

x=3
y=5.7
lan_name="python scripting"
my_var_output=f"The x value is {x}; the y value is {y} and the language value is {lan_name}."
print(my_var_output)

# Output
The x value is 3; the y value is 5.7 and the language value is python scripting.
```
