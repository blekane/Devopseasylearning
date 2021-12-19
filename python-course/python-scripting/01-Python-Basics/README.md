
### Application areas of Python
- Web-Application Development
- API Development
- Desktop GUI Application Development
- Data Analysis
- AI (Artificial Intelligence)
- Web Scraping &Text Processing
- Selenium Testing with Python
- Automation

### Why Python is popular?
- Python is easy to learn because of its simple syntaxes.
- Many modules(pre-defined and third party modules).
- Code length is very short because of third party modules.
- Platform Independent (the same code can run on every OS like windows, Linux and MacOS).
- Supports both functional and oops concepts.

### What is Python ?
Python is a powerful multi-purpose programming language (we can use it almost in any area of IT) created by Guido van Rossum

### Python Versions
There are two types of Python versions.
- 2.x
- 3.x
- We will go with Python 3.x. (3.7.0)


## Python 3.9 installation
- **Download Reference:** https://www.python.org/downloads/release

### Script to install Python 3.9 on Linux

```sh
wget https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz
tar -xvzf Python-3.9.0.tgz
yum install gcc openssl-devel bzip2-devel libffi-devel -y
cd Python-3.9.0
./configure
make
make altinstall
ls -ltr /usr/local/bin/

python3.9 --version

cd /usr/local/bin/
ln -s python3.9 python3
python3.9 --version

ln -s pip3.9 pip3
pip3 --version
```

### Install python3 on AWS EC2
```sh
yum -y update
sudo amazon-linux-extras install python3
python3 --version
which python3
```

### Run python script on Windows os
- Add it a path if you didn't do so while installing python
    - env
    - environment variables
    - user variables
    - path and edit
- use the `which python` command in git bash to find the path `/c/Users/Owner/AppData/Local/Programs/Python/Python37-32/python`
- set the path `C:\Users\Owner\AppData\Local\Programs\Python\Python37-32\`
```
python <script name>.py
python hello.py
```

### Run python script on Linux os
```
#For a specific version of python on Linux
python3 <script name>
python3 hello.py

# This will run with pyhon 2 by default on Linux
python <script name>
python hello.py
```

### Run python script on Linux os with the shebang
- use `which python3` command to get the path
- set that path as a shebang `#!/usr/local/bin/python3`
- give execute permission to the script `chmod +x a.py`
- and just use ./<script name> to run the script `./a.py`
```
which python3
/usr/local/bin/python3

which python
/usr/bin/python
```

```py
# This will use python3
#!/usr/local/bin/python3
print("Line 1")
print("Line 2")
print("")
print("Line 1 \nLine 2 \nLine 3")

# This will use python2
#!/usr/local/bin/python
print("Line 1")
print("Line 2")
print("")
print("Line 1 \nLine 2 \nLine 3")
```

### Run python code in Subline text
```
ctrl + b
```

### Exit python shell on Linux
```
exit()
```

### Print a string in python
```py
print("Welcome to python scripting for automation")
```

### Indentation in Python
- Indent --> space
- Indentations are used to represent a block of code.
- The amount of indentation is up to you, but it must be consistent throughout that block.
- Don’t include an indent unnecessarily.
```py
if 3 > 1:
    print("We are using if condition")
    print("We are comparing 3 and 1")
print("We are happy with indentations")

# Output
We are using if condition
We are comparing 3 and 1
We are happy with indentations

if 3 > 1:
    print("We are using if condition")
     print("We are comparing 3 and 1")
print("We are happy with indentations")

# Output
File "hello.py", line 3
    print("We are comparing 3 and 1")
    ^
IndentationError: unexpected indent

if 3 > 1:
    print("We are using if condition")
    print("We are comparing 3 and 1")
 print("We are happy with indentations")

 # Output
File "hello.py", line 4
    print("We are happy with indentations")
    ^
IndentationError: unindent does not match any outer indentation level
```

## Comments on python
### Multiple lines comment
- This code will become a documentation or a text if we start it by 3 apostrophies and end with 3 apostrophies
- The only code here is hello world and it will be printting.
- Green colors in python are either strings or comments.
- ctrl + / (to comment and uncomment multiple lines)

```py
'''name = input("What is your name?: ")
print("Nice to meet you " + name + "!" + " I am Leo from the USA." )
country = input("Where are you from?: ")
print("wow! " + country + " is a beautiful country. Isn't is?")
answer = input("Answer: ")
question5 = input("Once again thanks.")'''

'''
name = input("Enter your name: ")
print("Hello " + name +"!" )
'''

''' Python will print only hello world'''

print("hello world")
```
### Single line comment
- Use a #
```
# if 3 > 1:
#     print("We are using if condition")
#     print("We are comparing 3 and 1")
#  print("We are happy with indentations")
```

### Assingning a text or paragraph in Python.
- Triple quote is to print the entire text.
- This means we are assigninig all this text to introduction
```py
Introduction = '''The traditional American school year is designed around a nine-month schedule requiring 180 days in the classroom.
This schedule was established when the United States was still a largely agrarian nation.
Many people are advocating a shift away from this 9-month school year in favor of year-round education.
Some think it will better prepare them for college, and others think that it will not make a difference if the school
year is extended. There are many points that lead to the conclusion of why the academic school year should be extended
with no summer vacation. It will improve education, benefit low-income families, and will also allow kids to graduate
earlier as well.'''

print(Introduction)
```

### Keywords in Python
- Keywords cannot be use as variable name such as: pass = 'hello'
- Here is a list of the Python keywords.
```py
import keyword
print(keyword.kwlist)
```

### Operators
- Variables are allways one word
- If you write for instance: bad name = 5+3, you will have and error
- Write badname = 5+3 instead.

### Python extension
- PYTHON files extension is .py
- For example: tia.py

### Operators
- Booleans operation are either true or false operation
- Float are numbers such as 1.1, 2.4, 6.30 etc.
- Strings are sequence of uniode characters
- List are sequence of values

### Upper and lower
```py
# this well change hello to upper character
s = "Hello"
s.upper()

# this will change hello world to lower character
c = "HELLO WORLD"
c.lower()
```

### How to add two strings
```py
s0 = "Happy" + "holidays"
s1 = "Happy" + " holidays"
s2 = "Happy " + "holidays"
s3 = "Happy, " + "holidays"
s4 = "Happy" + "," + "holidays"
s5 = "Happy" + ", " + "holidays"

print(s0)
print(s1)
print(s2)
print(s3)
print(s4)
print(s5)

# Output
    Happyholidays
    Happy holidays
    Happy holidays
    Happy, holidays
    Happy,holidays
    Happy, holidays
```

### Special Character \n (new line)
```py
print("Line 1")
print("Line 2")
print("")
print("Line 1 \nLine 2 \nLine 3")

# Output
Line 1
Line 2

Line 1
Line 2
Line 3
```

### Escape special character
Use \ or " "
```py
print("python's class")
Or
print("python\'s class")
# Output
python's class

print('python's class')
# Output
SyntaxError: invalid syntax
```

### Tap special character (\t)
```py
print("Line 1 \n\tLine 2 \n\tLine 3")
# Output
Line 1
	Line 2
	Line 3

print("Line 1 \t\t\tLine 2 \t\tLine 3")
# Output
Line 1 			Line 2 		Line 3
```

### Print something in double quote
```py
print("This is \"python\" class for automation")
print('This is \"python\" class for automation')
print('This is "python" class for automation')

# Output
This is "python" class for automation
```

### Printing a path in Windows
- This will create a problem because in windows \ is a special character
- we need \\ when we want to write windows path

```py
print("C:\Users\Owner\Dropbox\AWS-EKS\TIA-NOTES\PYTHON-SCRIPTING")
# Output
SyntaxError: (unicode error) 'unicodeescape' codec can't decode bytes in position 2-3: truncated \UXXXXXXXX escape

print("C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING")
# Output
C:\Users\Owner\Dropbox\AWS-EKS\TIA-NOTES\PYTHON-SCRIPTING
```

### Printing a path in Linux
```py
print("/home/tia/scrip")

# Output
/home/tia/scrip
```


### Installing Linux packages via Python
```py
import subprocess

package_name = "httpd"
subprocess.run(["sudo", "yum", "install", "-y", package_name], check=True)
```

### Remove Linux packages via Python
```py
import subprocess
package_name = "httpd"
subprocess.run(["sudo", "yum", "remove", "-y", package_name], check=True)
```


```py
x=3
y=5.7
lan_name="python scripting"

print(x,y,lan_name)
print(f"The x value is {x}; the y value is {y} and the language value is {lan_name}.")
print(f"The x value is {x}; \nThe y value is {y} \nThe language value is {lan_name}.")

#OUTPUT
3 5.7 python scripting
The x value is 3; the y value is 5.7 and the language value is python scripting.
The x value is 3;
The y value is 5.7
The language value is python scripting.
```


## \n means new line
```py
print("Happy Birthday to you!")
print("Happy Birthday to you!\n")
print("Happy  Birthday to you, dear Emey. \n")
print("Happy Birthday to you!,\n")
print("Hope you ha ve a wonderful birthday!")
```

## Comments in python
```py
'''The traditional American school year is designed around a nine-month schedule requiring 180 days in the classroom.
This schedule was established when the United States was still a largely agrarian nation.'''


'''
The traditional American school year is designed around a nine-month schedule requiring 180 days in the classroom.
This schedule was established when the United States was still a largely agrarian nation.
'''

# this code will become a documentation or a text if we start it by 3 apostrophes and end with 3 apostrophes
# the only code here is hello world and it will be printing.
# green colors in python are either strings or comments.

'''name = input("What is your name?: ")
print("Nice to meet you " + name + "!" + " I am Leo from the USA." )
country = input("Where are you from?: ")
print("wow! " + country + " is a beautiful country. Isn't is?")
answer = input("Answer: ")
print("I really love you country because everything there is well organize.")
question1 = input("So where do you live know?: ")
print("Really! This is amazing we are neighbors!")
question3 = input("How long have you been here " + question1 + "?:")
print("Wow! you just live here " + question3 + " like my friend Jhon." +  " He have been here only for " +
      question3 + " in the USA too.")
question4 = input("Do you mind if i have your phone number?: ")
print("Thank so much " + name + " i really appreciate it. mine is 860 862 1352. I will call you tomorrow.")
print("Good bye!")
question5 = input("Once again thanks.")'''

'''
name = input("Enter your name: ")
print("Hello " + name +"!" )
'''

''' Python will print only hello world'''

print("hello world")

```

## Assingning a text or paragraph in Python
```py
# triple quote is to print the entire text.
# this means we are assigning all this text to introduction

Introduction = '''The traditional American school year is designed around a nine-month schedule requiring 180 days in
the classroom. This schedule was established when the United States was still a largely agrarian nation. Many people
are advocating a shift away from this 9-month school year in favor of year-round education. Some think it will better
prepare them for college, and others think that it will not make a difference if the school year is extended. There
are many points that lead to the conclusion of why the academic school year should be extended with no summer
vacation. It will improve education, benefit low-income families, and will also allow kids to graduate earlier as
well. '''

print(Introduction)
```

## Keywords in Python
```py
# Keywords cannot be use as variable name such as: pass = 'hello'
# Type the comment help() in python and hit enter
# when python bring up the prompt, the keywords and hit enter and all the keywords will be display.
# Here is a list of the Python keywords.  Enter any keyword to get more help.
'''
False               class               from                or
None                continue            global              pass
True                def                 if                  raise
and                 del                 import              return
as                  elif                in                  try
assert              else                is                  while
async               except              lambda              with
await               finally             nonlocal            yield
break               for                 not
'''
```

## How to add two strings
```py
s0 = "Happy" + "holidays"
s1 = "Happy" + " holidays"
s2 = "Happy " + "holidays"
s3 = "Happy, " + "holidays"
s4 = "Happy" + "," + "holidays"
s5 = "Happy" + ", " + "holidays"
print(s0)
print(s1)
print(s2)
print(s3)
print(s4)
print(s5)
```

### Find and replace
```py
# we use comment replace to replace word in the string
# it did not replace it because we have to use a new variable
e = "i am not felling well today and nothing is going well at this moment"
e.replace("and", "because")
print(e)

# we set new variable here
e = "i am not felling well today and nothing is going well at this moment"
g = e.replace("and", "because")
print(g)
```


