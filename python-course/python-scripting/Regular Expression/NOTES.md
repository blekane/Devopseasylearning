
# How to Write and Match Regular Expressions (Regex) [here](https://www.youtube.com/watch?v=K8L6KVGG-7o)
```
.       - Any Character Except New Line
\d      - Digit (0-9)
\D      - Not a Digit (0-9)
\w      - Word Character (a-z, A-Z, 0-9, _)
\W      - Not a Word Character
\s      - Whitespace (space, tab, newline)
\S      - Not Whitespace (space, tab, newline)

\b      - Word Boundary
\B      - Not a Word Boundary
^       - Beginning of a String
$       - End of a String

[]      - Matches Characters in brackets
[^ ]    - Matches Characters NOT in brackets
|       - Either Or
( )     - Group

Quantifiers:
*       - 0 or More
+       - 1 or More
?       - 0 or One
{3}     - Exact Number
{3,4}   - Range of Numbers (Minimum, Maximum)
```

#### Sample Regexs ####

[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+


## Raw string
```py
import re
print("\tTab")
print(r"\tTab")

OUTPUT
        Tab
\tTab
```

### Search for abc in text_to_search
```py
import re

text_to_search = '''
abcdefghijklmnopqurtuvwxyzabc
ABCDEFGHIJKLMNOPQRSTUVWXYZ
1234567890
Ha HaHa
MetaCharacters (Need to be escaped):
. ^ $ * + ? { } [ ] \ | ( )
coreyms.com
321-555-4321
123.555.1234
123*555*1234
800-555-1234
900-555-1234
Mr. Schafer
Mr Smith
Ms Davis
Mrs. Robinson
Mr. T
'''

sentence = 'Start a sentence and then bring it to an end'


pattern = re.compile(r'abc')
matches = pattern.finditer(text_to_search)
for match in matches:
    print(match)
    print(text_to_search[1:4])
    print(text_to_search[27:30])

#OUTPUT
<re.Match object; span=(1, 4), match='abc'>
abc
abc
<re.Match object; span=(27, 30), match='abc'>  
abc
abc
```

## Search for special characters
MetaCharacters like `. ^ $ * + ? { } [ ] \ | ( )` (Need to be escaped) with `\`

search for `.` in `text_to_search`
```py
pattern = re.compile(r'\.')
matches = pattern.finditer(text_to_search)
for match in matches:
    print(match)

#OUTPUT
<re.Match object; span=(114, 115), match='.'>
<re.Match object; span=(149, 150), match='.'>  
<re.Match object; span=(170, 171), match='.'>  
<re.Match object; span=(174, 175), match='.'>  
<re.Match object; span=(221, 222), match='.'>  
<re.Match object; span=(252, 253), match='.'>  
<re.Match object; span=(265, 266), match='.'>
```

## Search for coreyms.com in text_to_search
```py
pattern = re.compile(r'coreyms\.com')
matches = pattern.finditer(text_to_search)
for match in matches:
    print(match)
    print(text_to_search[142:153])


#OUTPUT
<re.Match object; span=(142, 153), match='coreyms.com'>
coreyms.com
```


## Search for `Start` in sentence (beginning)
```py
sentence = 'Start a sentence and then bring it to an end'

pattern = re.compile(r'^Start')
matches = pattern.finditer(sentence)
for match in matches:
    print(match)
    print(sentence[0:5])


#OUTPUT
<re.Match object; span=(0, 5), match='Start'>
Start
```

## Search for `end` in sentence (end)
```py
sentence = 'Start a sentence and then bring it to an end'


pattern = re.compile(r'end$')
matches = pattern.finditer(sentence)
for match in matches:
    print(match)
    print(sentence[41:44])


#OUTPUT
<re.Match object; span=(41, 44), match='end'>
end
```

### Search characters
```py
import re
text_to_search = '''This is my phone number: 321-555-4321'''

pattern = re.compile(r'\d\d\d.\d\d\d.\d\d\d')
matches = pattern.finditer(text_to_search)
for match in matches:
    print(match)
    print(text_to_search[25:36])

#OUTPUT
<re.Match object; span=(25, 36), match='321-555-432'>
321-555-432



import re
text_to_search = '''This is my phone number: 321'''

pattern = re.compile(r'\d\d\d')
matches = pattern.finditer(text_to_search)
for match in matches:
    print(match)
    print(text_to_search[25:28])

#OUTPUT
<re.Match object; span=(25, 28), match='321'>
321
```


## Dot (.) will matche all seperators
```py
import re
text_to_search = '''
321-555-4321
123.555.1234
123*555*1234
'''

pattern = re.compile(r'\d\d\d.\d\d\d.\d\d\d')
matches = pattern.finditer(text_to_search)
for match in matches:
    print(match)

#OUTPUT
<re.Match object; span=(1, 12), match='321-555-432'>
<re.Match object; span=(14, 25), match='123.555.123'>
<re.Match object; span=(27, 38), match='123*555*123'>
```

## Use character search to match (match `.`)
```py
import re
text_to_search = '''
321-555-4321
123.555.1234
123*555*1234
'''

pattern = re.compile(r'\d\d\d[.]\d\d\d[.]\d\d\d')
matches = pattern.finditer(text_to_search)
for match in matches:
    print(match)

#OUTPUT
<re.Match object; span=(14, 25), match='123.555.123'>
```

## Use character search to match (match `-`)
```py
import re
text_to_search = '''
321-555-4321
123.555.1234
123*555*1234
'''

pattern = re.compile(r'\d\d\d[-]\d\d\d[-]\d\d\d')
matches = pattern.finditer(text_to_search)
for match in matches:
    print(match)
    
#OUTPUT
<re.Match object; span=(1, 12), match='321-555-432'>
```

## Use character search to match (match `-` or `.`)
```py
import re
text_to_search = '''
321-555-4321
123.555.1234
123*555*1234
'''

pattern = re.compile(r'\d\d\d[-.]\d\d\d[-.]\d\d\d')
matches = pattern.finditer(text_to_search)
for match in matches:
    print(match)
    
#OUTPUT
<re.Match object; span=(1, 12), match='321-555-432'>
<re.Match object; span=(14, 25), match='123.555.123'>
```

## Use character search to match (match `-` or `.` or `*`)
```py
import re
text_to_search = '''
321-555-4321
123.555.1234
123*555*1234
'''

pattern = re.compile(r'\d\d\d[-.*]\d\d\d[-.*]\d\d\d')
matches = pattern.finditer(text_to_search)
for match in matches:
    print(match)
    
#OUTPUT
<re.Match object; span=(1, 12), match='321-555-432'>
<re.Match object; span=(14, 25), match='123.555.123'>
<re.Match object; span=(27, 38), match='123*555*123'>
```

## Match the exact number
```py
import re
text_to_search = '''
321-555-4321
123.555.1234
123*555*1234
'''

pattern = re.compile(r'\d{3}[-]\d{3}[-]\d{4}')
matches = pattern.finditer(text_to_search)
for match in matches:
    print(match)

#OUTPUT
<re.Match object; span=(1, 13), match='321-555-4321'>
```

## Match one or more elements (this is usefull when we don't know the number of character before and after the comma)
```py
import re
text_to_search = '''321.18'''

pattern = re.compile(r'\d*[.]\d*') # everything after the comma
matches = pattern.finditer(text_to_search)
for match in matches:
    print(match)

#OUTPUT
<re.Match object; span=(0, 6), match='321.18'>
```

```py
import re
text_to_search = '''321'''

pattern = re.compile(r'\d*')
matches = pattern.finditer(text_to_search)
for match in matches:
    print(match)

#OUTPUT
<re.Match object; span=(0, 3), match='321'>
<re.Match object; span=(3, 3), match=''>
```

```py
import re
text_to_search = '''321.02144'''

pattern = re.compile(r'\d*[.]\d{2}') # 2 characters after a comma
matches = pattern.finditer(text_to_search)
for match in matches:
    print(match)

#OUTPUT
<re.Match object; span=(0, 6), match='321.02'>
```


### Filter from email
```py
import re

emails = '''
CoreyMSchafer@gmail.com
corey.schafer@university.edu
corey_321-schafer@my-work.net
'''
pattern = re.compile(r'[a-zA-Z]+@[a-zA-Z]+\.com')  # first email
pattern = re.compile(r'[a-z.]+@[a-z]+\.edu')  # second email
pattern = re.compile(r'[a-zA-Z0-9-_]+@[a-zA-Z-]+\.net')  # third email first
pattern = re.compile(r'[a-zA-Z.]+@[a-z]+\.(com|edu)')  # first and second email

# first and third email
pattern = re.compile(r'[a-zA-Z0-9_-]+@[a-z-]+\.(com|net)')

# match all
pattern = re.compile(r'[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+')
pattern = re.compile(r'[a-zA-Z0-9_.+-]+@[a-zA-Z-]+\.[a-zA-Z-.]+')

matches = pattern.finditer(emails)

for match in matches:
    print(match)
```


## EXAMPLE: Check the Kernel Version
```py
import subprocess
import re
cmd = ["uname", "-a"]
sp = subprocess.Popen(cmd, shell=False, stdout=subprocess.PIPE,
                      stderr=subprocess.PIPE, universal_newlines=True)
rc = sp.wait()
o, e = sp.communicate()

if rc == 0:
    for each_line in o.splitlines():
        if "x86_64" in each_line and "SMP" in each_line:
            print(each_line)
            # pattern = re.compile(r'\d.\d\d.\d')
            pattern = re.compile(r'\d{1}[.]\d{2}[.]\d{1}')
            matches = pattern.finditer(each_line)
            for match in matches:
                print(match)
                print(each_line[13:19])

                if each_line[13:19] >= "5":
                    print("The Kernel version is: {}".format(each_line[13:19]))
else:
    print("Command was failed and error is: ", e)


# OUTPUT
Linux ubuntu 5.11.0-43-generic #47~20.04.2-Ubuntu SMP Mon Dec 13 11:06:56 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
<re.Match object; span=(13, 19), match='5.11.0'>
5.11.0
The Kernel version is: 5.11.0
<re.Match object; span=(33, 39), match='7~20.0'>
5.11.0
The Kernel version is: 5.11.0
<re.Match object; span=(63, 69), match='3 11:0'>
5.11.0
The Kernel version is: 5.11.0
```

## EXAMPLE (not good one and it can't work everywhere because `5.0.17` is hard code)
```py
import subprocess
import re
cmd=["bash","--version"]
sp=subprocess.Popen(cmd,shell=False,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
o,e=sp.communicate()

if rc==0:
   for each_line in o.splitlines():
      if "version" in each_line  and "release" in each_line:
        #  print(each_line.split()[3].split('(')[0])
        print(each_line)
        print(re.findall("5.0.17",each_line)[0])
        VERSION = re.findall("5.0.17",each_line)[0]
        if VERSION >= "5":
            print("The bash version is: {}".format(VERSION))
else:
   print("Command was failed and error is: ",e)
```

## EXAMPLE (good one and it can work everywhere)
```py
import subprocess
import re
cmd = ["bash", "--version"]
sp = subprocess.Popen(cmd, shell=False, stdout=subprocess.PIPE,
                      stderr=subprocess.PIPE, universal_newlines=True)
rc = sp.wait()
o, e = sp.communicate()

if rc == 0:
    for each_line in o.splitlines():
        if "version" in each_line and "release" in each_line:
            print(each_line)
            # pattern = re.compile(r'\d.\d.\d\d')
            pattern = re.compile(r'\d{1}[.]\d{1}[.]\d{2}')
            matches = pattern.finditer(each_line)
            for match in matches:
                print(match)
                print(each_line[18:24])

                if each_line[18:24] >= "5":
                    print("The bash version is: {}".format(each_line[18:24]))
else:
    print("Command was failed and error is: ", e)

# OUTPUT
GNU bash, version 5.0.17(1)-release (x86_64-pc-linux-gnu)
<re.Match object; span=(18, 24), match='5.0.17'>
5.0.17
The bash version is: 5.0.17
```

## EXAMPLE
```py
#!/usr/local/bin/python3
import subprocess
import os

sp=subprocess.Popen("cat /etc/sysconfig/selinux",shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
out,err=sp.communicate()

print(type(out) is type(b))
print(b,type(b))
print(out,type(out))

try:
    for  each_line in out.splitlines():
        if "SELINUX" in each_line and "enforcing" in each_line:
            # SELINUX =  each_line.split("=")[0]
            print(re.findall("enforcing", each_line)[0])
            SELINUX = re.findall("enforcing", each_line)[0]
            if SELINUX == "enforcing"
                print("SELINUX CHECK PASSED")
except:
    print(e)
else:
    os.system("sed -i '/^SELINUX/d' /etc/sysconfig/selinux")
    os.system("sed -i '/#     disabled - No SELinux policy is loadeaSELINUX=enforcing' /etc/sysconfig/selinux")
    print("SELINUX CHECK FAILED. Selinux was set to ENFORCING mode")
```

## Momory information
```py
import subprocess
import re
cmd = ["free", "-h"]
sp = subprocess.Popen(cmd, shell=False, stdout=subprocess.PIPE,
                      stderr=subprocess.PIPE, universal_newlines=True)
rc = sp.wait()
o, e = sp.communicate()

if rc == 0:
    for each_line in o.splitlines():
        if "Mem" in each_line:
            print(each_line)
            pattern = re.compile(r'\d*[.]\d{1}')
            matches = pattern.finditer(each_line)
            for matches in each_line:
                print(matches)
                
                print("The total memory is: {}Gi".format(each_line[14:17]))
                print("The memory used is: {}Gi".format(each_line[26:29]))
                print("The memory available is: {}Gi".format(each_line[74:77]))
                break
else:
    print("Command was failed and error is: ", e)

# OUTPUT
Mem:          5.7Gi       3.1Gi       1.4Gi        50Mi       1.2Gi       2.3Gi
The total memory is: 5.7Gi
The memory used is: 3.1Gi
The memory available is: 2.3Gi



import subprocess
import re
cmd = ["free", "-h"]
sp = subprocess.Popen(cmd, shell=False, stdout=subprocess.PIPE,
                      stderr=subprocess.PIPE, universal_newlines=True)
rc = sp.wait()
o, e = sp.communicate()

if rc == 0:
    for each_line in o.splitlines():
        if "Mem" in each_line:
            print(each_line)
            pattern = re.compile(r'\d*[.]\d{1}')
            matches = pattern.findall(each_line)
            for matches in each_line:
                print(matches) 
                break
            if each_line[14:17] >= "5":
                print("The total memory check PASSED")
            else:
                print("The total memory check FAILED")
else:
    print("Command was failed and error is: ", e)

# OUTPUT
Mem:          5.7Gi       3.2Gi       1.1Gi        56Mi       1.5Gi       2.2Gi
The total memory check PASSED
```