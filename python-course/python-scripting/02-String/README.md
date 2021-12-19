# Working with Python strings

### Introduction:
### What is String in Python?
- A string is a sequence of characters.
- A character is simply a symbol. For example, the English language has 26 characters.
- Computers do not deal with characters, they deal with numbers (binary). Even though you may see characters on your screen, internally it is stored and b manipulated as a combination of 0's and 1's.
- This conversion of character to a number is called encoding, and the reverse process is decoding. ASCII and Unicode are some of the popular encoding used.
- In Python, string is a sequence of Unicode character. Unicode was introduced to include every character in all languages and bring uniformity in encoding.

### How to create a string in Python?

```py
string="""
We are learning python scripting
The is for automation
Python is very easy
"""
print(string)

#OUTPUT
We are learning python scripting
The is for automation
Python is very easy
```

### How to print multiple line
```py
string="""
            *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*==*=*
            *                    **** Warning ***                                      *
            *  This computer system is the private property of Data Service Group INC  *
            *  It is for authorized use only.                                          *
            *                                                                          *
            *  Unauthorized or improper use of this system may result in civil and     *
            *  criminal penalties and administrative or disciplinary action,as         *
            *  appropriate. By continuing to use this system you indicate your         *
            *  awareness of and consent to these terms and conditions of use. LOG OFF  *
            *  IMMEDIATELY if you do not agree to the conditions stated in this        *
            *  warning!!!!!                                                            *
            *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*==*=*
"""
print(string)


#OUTPUT
            *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*==*=*
            *                    **** Warning ***                                      *
            *  This computer system is the private property of Data Service Group INC  *
            *  It is for authorized use only.                                          *
            *                                                                          *
            *  Unauthorized or improper use of this system may result in civil and     *
            *  criminal penalties and administrative or disciplinary action,as         *
            *  appropriate. By continuing to use this system you indicate your         *
            *  awareness of and consent to these terms and conditions of use. LOG OFF  *
            *  IMMEDIATELY if you do not agree to the conditions stated in this        *
            *  warning!!!!!                                                            *
            *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*==*=*


```py
string="""
 BELOW ARE ALL TASK TO BE CHECK ON NEW SERVERS AND CHANGE SOME AS NEED
 ___________________________________________________________________________
*  1- Check if the CPU is at least 4000                                     *
*  2- check if the user admin exists on the server, if not create a user    *
*     admin with the password=redhat and give him root privilege            *
*  3- Check if a group helpdesk exists on the server. If not,               *
*      create a group helpdesk, add paul, John, tom (password = "redhat")   *
*      and give them root privilege to reset other users' passwords only.
*      NB: make sure that you expire users account
*  4- Check if the memory is at least 8G                                    *
*  5- Check the first digit of the  Kernel version is at least 3 and above  *
*  6- check if the root file system is not more than 10%                    *
*  7- Check if selinux is set to enforcing, if not enforced it              *
*  8- Check if the OS version is CentOs 6 or 7                              *
*  9- Check if the default runlevel is 3. If not, set it to 3.              *
*  10- Check if cron.allow is present on the server. If not, create it.     *
*  11- Check if sshd port 22 is open. if yes close                          *
*  12- Change the default ssh port to 29                                    *
*  13- Check if port 8080 is open. If not open port 8080                    *
*  14- check if port 80 is open on the server. If not, open port 80         *
*  15- Check if the password hash is SHA512. If not, change to SHA512       *
*  16- Check if password authentication is set to yes in ssh_config file.   *
*      If no, set it to yes                                                 *
*  17-  Check if the server will require a root for maintenance mode.       *
*       If not, set it to require root password for maintenance mode        *
*  18- Check if the password aging is enforced. If not, enforced            *
*      SET PASS_MAX_DAYS TO 90 DAYS                                         *
*      SET PASS_MIN_LEN TO 8                                                *
*      SET PASS_MIN_LEN TO 0                                                *
*      SET PASS_WARN_AGE TO 14 DAYS                                         *
*  19- Check if the grub password is set. If not, set the grub password.    *
*      The passowrd shoold be "redhat"                                      *
*___________________________________________________________________________*

BELOW IS THE RESULT OF WHAT WAS ON THE NEW AND WAS MODIFIED ON THAT NEW INSTALLED SERVER
"""
print(string)

#OUTPUT
BELOW ARE ALL TASK TO BE CHECK ON NEW SERVERS AND CHANGE SOME AS NEED
 ___________________________________________________________________________
*  1- Check if the CPU is at least 4000                                     *
*  2- check if the user admin exists on the server, if not create a user    *
*     admin with the password=redhat and give him root privilege            *
*  3- Check if a group helpdesk exists on the server. If not,               *
*      create a group helpdesk, add paul, John, tom (password = "redhat")   *
*      and give them root privilege to reset other users' passwords only.
*      NB: make sure that you expire users account
*  4- Check if the memory is at least 8G                                    *
*  5- Check the first digit of the  Kernel version is at least 3 and above  *
*  6- check if the root file system is not more than 10%                    *
*  7- Check if selinux is set to enforcing, if not enforced it              *
*  8- Check if the OS version is CentOs 6 or 7                              *
*  9- Check if the default runlevel is 3. If not, set it to 3.              *
*  10- Check if cron.allow is present on the server. If not, create it.     *
*  11- Check if sshd port 22 is open. if yes close                          *
*  12- Change the default ssh port to 29                                    *
*  13- Check if port 8080 is open. If not open port 8080                    *
*  14- check if port 80 is open on the server. If not, open port 80         *
*  15- Check if the password hash is SHA512. If not, change to SHA512       *
*  16- Check if password authentication is set to yes in ssh_config file.   *
*      If no, set it to yes                                                 *
*  17-  Check if the server will require a root for maintenance mode.       *
*       If not, set it to require root password for maintenance mode        *
*  18- Check if the password aging is enforced. If not, enforced            *
*      SET PASS_MAX_DAYS TO 90 DAYS                                         *
*      SET PASS_MIN_LEN TO 8                                                *
*      SET PASS_MIN_LEN TO 0                                                *
*      SET PASS_WARN_AGE TO 14 DAYS                                         *
*  19- Check if the grub password is set. If not, set the grub password.    *
*      The passowrd shoold be "redhat"                                      *
*___________________________________________________________________________*

BELOW IS THE RESULT OF WHAT WAS ON THE NEW AND WAS MODIFIED ON THAT NEW INSTALLED SERVER
```


### How to access characters in a string?
```py
string="python scripting"
print(string)
print(string[0:])
print(string[0])
print(string[-1])
print(string[0:6])

#OUTPUT
python scripting
python scripting
p
g
python
```

### How to change or delete a string?
Strings are immutable. This means that elements of a string cannot be changed once it has been assigned. We can simply reassign different strings to the same name.
```py
string="python scripting"
del string
print(string)
```


How to find the length of a string ?
```py
string="python scripting"
lent_1=len(string)
print(f'The lent of my string is: {lent_1}')

#OUTPUT
The lent of my string is: 16
```

### How to add/Concatenate two strings ?
```py
string1 = "Python scripting"
string2 = 'Devops course'
string3 = '{} {}'.format(string1, string2)
print(f'{string1} for {string2}')
print(f'{string1} for {string2}')
print(string3)

#OUTPUT
Python scripting for Devops course
```


### String conversion
```py
string="Python scripting for Devops course automation"
print(string)
print(string.lower())
print(string.upper())
print(string.title())

#OUTPUT
Python scripting for Devops course automation
python scripting for devops course automation
PYTHON SCRIPTING FOR DEVOPS COURSE AUTOMATION
Python Scripting For Devops Course Automation
```

### Boolean result operation on strings
```py
string1="Python scripting for Devops course automation"
string2=" "
print(bool(string1))
print(bool(string2))
print(string1.startswith('p'))
print(string1.startswith('P'))
print(string1.startswith('Python'))
print(string1.endswith('n'))
print(string1.endswith('automation'))
print(string1.endswith('course automation'))
print(string1.isupper())
print(string1.islower())
print(string1.istitle())
print(string1.isnumeric())

#OUTPUT
True
True
False
True
True
True
True
True
False
False
False
False
```

### Strip operations on strings
It will remove word at the beginning and end of a srting
This will remove space at the beginnig and the end of your string
```py
string1=" Python scripting for Devops course automation "
print(string1)
print(string1.strip())

#OUTPUT
 Python scripting for Devops course automation
Python scripting for Devops course automation
```

```py
string1="5Python3.9"
string2="3.9Python3.9"
print(string1)
print(string1.strip('3.9'))
print(string1.strip('5'))
print(string2.strip('3.9'))

#OUTPUT
5Python3.9
5Python
Python3.9
Python
```

```py
string1="5Python3.9"
print(string1.strip('3.9'))
print(string1.strip('5'))
print(string1.strip('3.9').strip('5').strip('thon'))

#OUTPUT
5Python
Python3.9
Py
```

### Strip and split operations on strings
It will split the string into list
```py
string1="Python3.7 scripting for Devops course automation"
print(string1.split())
print(string1.split()[0])
print(string1.split()[-1])
print(string1.split()[0].strip('3.7'))

#OUTPUT
['Python3.7', 'scripting', 'for', 'Devops', 'course', 'automation']
Python3.7
automation
Python
```

Split base on word
```py
string1="Python3.7 scripting for Devops course automation"
print(string1.split())
print(string1.split('for'))
print(string1.split('course'))
print(string1.split('3.7'))

#OUTPUT
['Python3.7', 'scripting', 'for', 'Devops', 'course', 'automation']
['Python3.7 scripting ', ' Devops course automation']
['Python3.7 scripting for Devops ', ' automation']
['Python', ' scripting for Devops course automation']
```

```py
string1="Python3.7 is very easy and it is very popular."
print(string1.split())
print(string1.split('is'))
print(string1.split('very'))

#OUTPUT
['Python3.7', 'is', 'very', 'easy', 'and', 'it', 'is', 'very', 'popular.']
['Python3.7 ', ' very easy and it ', ' very popular.']
['Python3.7 is ', ' easy and it is ', ' popular.']
```

```py
string1="3.7.6.34_564"
print(string1.split('.'))
print(string1.split('_'))

#OUTPUT
['3', '7', '6', '34_564']
['3.7.6.34', '564']
```

### Count, Index and find operation on strings
```py
string="python3.7 is very easy and it is very popular."
print(string.count('is'))
print(string.count('n'))
print(string.count('easy'))

print(string.index('easy'))
print(string.split().index('easy'))
print(string.split().index('it'))

#OUTPUT
2
2
1
18
3
5
23
38
```

```py

JAVA_VERSION='java version 1.7'
print(JAVA_VERSION.find('java')) # if the result is 0, java is in the string
print(JAVA_VERSION.find('java2')) # if the result is -1, java is not in the string
print(JAVA_VERSION.find('1.8'))

if JAVA_VERSION.find('java') == 0:
  print('java is in the giving string')
else:
  print('java is not in the giving string')


JAVA_VERSION4='java version 1.7'.split()
print(JAVA_VERSION4)

if 'java' in JAVA_VERSION4:
  print('java is in the giving string')
else:
  print('java is not in the giving string')

if 'java2' in JAVA_VERSION4:
  print('java is in the giving string')
else:
  print('java is not in the giving string')

#OUTPUT
0
-1
-1
java is in the giving string
['java', 'version', '1.7']
java is in the giving string
java is not in the giving string
```

## EXAPLE:
```PY
message = 'hello world'
print(message)

# how many characters is in our string? we call this a len of the function
# this the len of our function is 11
print(len(message))

# we can access each characters of our string. to print the first letter, we can use [0]
# this will print the first letter of our string
print(message[0])

# a space is count as one index
print(message[10])

# how to print a in the sting. hello for example. the first will start at 0 and at 5
# this means we want all the characters from 0 to 4 because the 5 is not included
print(message[0:5])

# we can use column to say the last index will be 5
print(message[:5])

# this means the last index is 10 because is not included
print(message[:11])
```

## EXAPLE:
```py
a = "i am not going to school"
print(a)
print(len(a))

print(a[17:])
print(a[0:14])

print(a[0:])
print(a)

# how to change from lower case to upper cas. we have to use .upper()
b = 'hello world'
print(a.upper())
print(b.upper())

# how to change from upper case to lower cas. we have to use .upper()
d = 'I AM NOT FELLING WELL TODAY AND NOTHING IS GOING WELL'
print(d.lower())

# how to use a count method
# this means well is written 2 times in this string
e = "i am not felling well today and nothing is going well at this moment"
print(e.count("well"))
print(e.count("and"))
# this means the character l is written 6 times in this string
print(e.count("l"))
print(e.count("a"))

# we can use finf comment to find the index of the word
print(e.find("at"))
print(e.find("f"))

print(len(e))

# the string of something that does not exist will -1
# this means python can find good in this string
print(e.find("good"))
```
