### Sys module 
This is the system env variables

```py
import sys 
dir(sys)
help(sys)

print(sys.version) # to print the python version
print(sys.path) # to print the path
```

### To exit or stop the script execution
```py
import sys 
print("Hello world")
sys.exit()
print("tia")

# Output
Hello world

import sys 
print("Hello world")
# we provide the exit code
sys.exit(5)
print("tia")

# Output
Hello world
```

```py
import sys

print(sys.argv)
print(len(sys.argv))

print("The list of all arguments is: {}".format(sys.argv))
print("The script name is: {}".format(sys.argv[0]))
print("The first argunet is: {}".format(sys.argv[1]))
print("The scond argunet is: {}".format(sys.argv[2]))
print("The third argunet is: {}".format(sys.argv[3]))

if len(sys.argv) == int(4):
    print("OK")
else:
    print("Hummmmmmmm")

# Output
$ python hello.py 1 2 3
['python.py', '1', '2', '3']
4
The list of all arguments is: ['python.py', '1', '2', '3']
The script name is: python.py
The first argunet is: 1
The scond argunet is: 2
The third argunet is: 3
OK
``

### Command line arguments
- This will display the number of argument that a user provide while running the script.
- It will return a list 
```py
import sys 
print(sys.argv)

# Output
$ python hello.py tia rice tom 3
['hello.py', 'tia', 'rice', 'tom', '3']
```

### Print some arguments provide by the user
```py
import sys 
print(sys.argv) # print all arg
print(sys.argv[0]) # print the script name 
print(sys.argv[1]) # print the first arg
print(sys.argv[-1]) # print the last argument
print(sys.argv[2]) # print the second argument

# Output
$ python hello.py tia rice tom 3
['hello.py', 'tia', 'rice', 'tom', '3']
hello.py
3
rice
```
#-----------------------------------------------------------------------
### Use if statement to take action base of arg
```py
import sys 
print(sys.argv) # print all arg
print(sys.argv[0]) # print the script name or first arg
print(sys.argv[-1]) # print the last argument
print(sys.argv[2]) # print the second argument

x=int((sys.argv[-1]))
print(x)
if x > 5:
    print("True")
else:
    print("false")

# Output
$ python hello.py tia rice tom 3
['hello.py', 'tia', 'rice', 'tom', '3']
hello.py
3
rice
3
false
```
#-----------------------------------------------------------------------
### We will have an error if the user do not provide all the require arg
```py
import sys 
usr_string=sys.argv[1]
usr_action=sys.argv[2]

if usr_action == "lower":
    print(usr_string.lower())
elif usr_action == "upper":
    print(usr_string.upper())
elif usr_action == "title":
    print(usr_string.title())
else:
    print("Your action is invalid. Please select between upper/lower/title")

# Outputs
$ python hello.py "this Is PythoN scripTing course" lower
this is python scripting course

$ python hello.py "this Is PythoN scripTing course" upper
THIS IS PYTHON SCRIPTING COURSE

$ python hello.py "this Is PythoN scripTing course" title
This Is Python Scripting Course
```
#-----------------------------------------------------------------------
### Check the number of arg
```py
import sys 
print("The number of command line arguments: ", len(sys.argv))

# Output
$ python hello.py "this Is PythoN scripTing course" title
The number of command line arguments:  3
```
#-----------------------------------------------------------------------
### Check the number of arg and exit if it not 3 and continue if it is not 3
```py
import sys 

if len(sys.argv) != 3:
    print("Usage: ")
    print("The number of arguments is less than 3.")
    print(f"{sys.argv[0]} <Your require string> <|upper|lower|title|")
    sys.exit()

usr_string=sys.argv[1]
usr_action=sys.argv[2]

if usr_action == "lower":
    print(usr_string.lower())
elif usr_action == "upper":
    print(usr_string.upper())
elif usr_action == "title":
    print(usr_string.title())
else:
    print("Your action is invalid. Please select between upper/lower/title")

# Output
$ python hello.py "this Is PythoN scripTing course"
Usage:
The number of arguments is less than 3.
hello.py <Your require string> <|upper|lower|title|
```

### Check the length of a string
```py
a=str("Your action is invalid. Please select between upper/lower/title")
print(len(a))

# Output
$ python hello.py
63
```

## EXAMPLE
```PY
import sys

ENVIRONMENT_PROD = "prod"
ENVIRONMENT_NONPROD = "nonprod"

PARAM_ENV = sys.argv[1]
PARAM_TAG = sys.argv[3]
VALUE = sys.argv[2]
TAG = sys.argv[4]


def HELP():
    print()
    print("ERROR: Check the below usage to build the image according to your environement: ")
    print("Usage for Jenkins nonprod image: {} --env {} --tag <image tag name>".format(sys.argv[0], ENVIRONMENT_NONPROD))
    print( "Usage for Jenkins prod image: {} --env {} --tag <image tag name>".format(sys.argv[0], ENVIRONMENT_PROD))
    print("Example: {} --env {} --tag jenkins-nonprod".format(sys.argv[0], ENVIRONMENT_PROD))
    print()


if VALUE == ENVIRONMENT_NONPROD and PARAM_ENV == "--env"  and PARAM_TAG == "--tag": 
    print("Building Jenkins {} image and pushing it into AWS ECR".format(VALUE))
    sys.exit()

elif VALUE == ENVIRONMENT_PROD and PARAM_ENV == "--env"  and PARAM_TAG == "--tag": 
    print("Building Jenkins {} image and pushing it into AWS ECR".format(VALUE))
    sys.exit()
else:
    HELP()
    sys.exit()


# OUTPUT 1
$ python3 python.py --env prod --tagssssss jenkins-nonprod

ERROR: Check the below usage to build the image according to your environement: 
Usage for Jenkins nonprod image: python.py --env nonprod --tag <image tag name>
Usage for Jenkins prod image: python.py --env prod --tag <image tag name>
Example: python.py --env prod --tag jenkins-nonprod

# OUTPUT 2
$ python3 python.py --env prod --tag jenkins-nonprod
Building Jenkins prod image and pushing it into AWS ECR
```