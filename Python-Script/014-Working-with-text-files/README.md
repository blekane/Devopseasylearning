# Working with text files using python
**We can open a file in 3 modes:**
- append mode (a): add centent at the end of the file and safe
- Write mode (w): write a safe. This will overwrite the content of the file if the file exist already. if not, it will create it and add the content.
- Read mode (r): to read the content of the file

### Create and empty file 
```py
fo1 = open("C:\\Users\\Owner\\Downloads\\resume\\test1.txt", "w")
fo2 = open("test1.txt", "w")

fo1.close()
fo2.close()
```

### Check the state of a file
```py
fo1 = open("C:\\Users\\Owner\\Downloads\\resume\\test1.txt", "w")
fo2 = open("test1.txt", "w")

print(fo1.readable())
print(fo1.writable())

fo1.close()
fo2.close()

#OUTPUT
False
True
```

### Write into a file
```py
fo = open("test1.txt", "w")

fo.write("This is the first line\n")
fo.write("This is the second line\n")
fo.write("This is the third line\n")

fo.close()

#OUTPUT
This is the first line
This is the second line
This is the third line
```

### Writing multiple lines
```py

fo = open("test1.txt", "w")

fo.write("""This is the first line
This is the second line
This is the third line
This is the fourth line
""")

fo.close()

#OUTPUT
This is the first line
This is the second line
This is the third line
This is the fourth line
```

### Install a web server with os.path()
```py
#!/usr/local/bin/python3
import os
path_httpd="/var/www/html"
print(os.path.exists(path_httpd))

if os.path.exists(path_httpd):
    print("Apache in install already")
else:
    os.system("yum -y install httpd")
    os.system("systemctl start httpd  && systemctl enable httpd")
    os.chdir("/var/www/html")
    
    fo = open("/var/www/html/index.html", "w")
    fo.write("""
    <!DOCTYPE html>
    <html>
    <body>

    <h2 title="I'm a header">The title Attribute</h2>

    <p title="I'm a tooltip">Mouse over this paragraph, to display the title attribute as a tooltip.</p>

    </body>
    </html
    """)

    fo.close()
    os.system("firewall-cmd --zone=public --permanent --add-port=80/tcp && firewall-cmd --reload")


### Use list to put content into a file
```py
my_content=["This is a data -1\n","This is a data-2\n","This is a data-3"]
fo=open("C:\\Users\\Owner\\Downloads\\resume\\random.txt",'w')
fo.writelines(my_content)
fo.close()

#OUTPUT
This is a data -1
This is a data-2
This is a data-3
```

### Using loop to write into file
```py
my_content=['This is using loop-iteratioin-1','This is using loop-iterantion-2','This is using loop-iteratioin-3']

fo=open("C:\\Users\\Owner\\Downloads\\resume\\loop.txt",'w')

for each_line in my_content:
  fo.write(each_line+"\n")
fo.close()

#OUTPUT
This is using loop-iteratioin-1
This is using loop-iterantion-2
This is using loop-iteratioin-3
```

### Append new data
```py
my_content=['This is using loop-iteratioin-1','This is using loop-iterantion-2','This is using loop-iteratioin-3']

fo=open("C:\\Users\\Owner\\Downloads\\resume\\loop.txt",'a')

for each_line in my_content:
  fo.write(each_line+"\n")
fo.close()

#OUTPUT
This is using loop-iteratioin-1
This is using loop-iterantion-2
This is using loop-iteratioin-3
This is using loop-iteratioin-1
This is using loop-iterantion-2
This is using loop-iteratioin-3
```


### Read a file and print the content
```py
fo=open("C:\\Users\\Owner\\Downloads\\resume\\loop.txt",'r')
print(fo.read())
fo.close()

#OUTPUT
This is using loop-iteratioin-1
This is using loop-iterantion-2
This is using loop-iteratioin-3
This is using loop-iteratioin-1
This is using loop-iterantion-2
This is using loop-iteratioin-3
```


### Read a file, store the  content into a variable and print the content
```py
fo=open("C:\\Users\\Owner\\Downloads\\resume\\loop.txt",'r')
data=fo.read()
fo.close()

print(data)

#OUTPUT
This is using loop-iteratioin-1
This is using loop-iterantion-2
This is using loop-iteratioin-3
This is using loop-iteratioin-1
This is using loop-iterantion-2
This is using loop-iteratioin-3
```

### Read a file as a list
```py
fo=open("C:\\Users\\Owner\\Downloads\\resume\\loop.txt",'r')
data=fo.readlines()
fo.close()

print(data)

#OUTPUT
['This is using loop-iteratioin-1\n', 'This is using loop-iterantion-2\n', 'This is using loop-iteratioin-3\n', 'This is using loop-iteratioin-1\n', 'This is using loop-iterantion-2\n', 'This is using loop-iteratioin-3\n']
```

```py
fo=open("C:\\Users\\Owner\\Downloads\\resume\\loop.txt",'r')
data=fo.readlines()
fo.close()
print(data[-1])

#OUTPUT
This is using loop-iteratioin-3
```

### Use for loop to print the first 3 lines in the file
```py
fo=open("C:\\Users\\Owner\\Downloads\\resume",'r')
data=fo.readlines()
fo.close()

for each in range(3):
  print(data[each])   #data[0], data[1],data[2]

#OUTPUT
This is using loop-iteratioin-1

This is using loop-iterantion-2

This is using loop-iteratioin-3
```


### How to split a file into a list in Python?
```py
f = open("test.txt", "r")
content = f.read()

content_list = content.splitlines()
f.close()
print(content_list)
```

### How to split a file into a list in Python and grep some lines?
```py
f = open("test.txt", "r")
content = f.read()

content_list = content.splitlines()
f.close()
print(content_list)

print(' ')

for each_line in content_list:
  if "Location" in each_line  and " Number" in each_line:
     print(each_line)
     print(each_line.split())
```

### How to split a file into a list in Python, grep some lines and write those lines into a file?
```py
f = open("test.txt", "r")
content = f.read()

content_list = content.splitlines()
f.close()
# print(content_list)

print(' ')

outF = open("myOutFile.txt", "w")
for each_line in content_list:
  if "Location" in each_line  and " Number" in each_line:
     print(each_line)
     print(each_line.split())

     outF.write(each_line)
     outF.write("\n")
outF.close()
```

```py
f = open("test.txt", "r")
content = f.read()

content_list = content.splitlines()
f.close()
# print(content_list)

print(' ')

outF = open("myOutFile.txt", "w")
for each_line in content_list:
  if "0" in each_line and "2" in each_line:
     print(each_line)
     print(each_line.split())

     outF.write(each_line)
     outF.write("\n")
outF.close()
```

### How to split a file into a list in Python, grep some lines and write those lines into a csv or excel file?
```py
f = open("test.txt", "r")
content = f.read()

content_list = content.splitlines()
f.close()

print(' ')

outF = open("myOutFile.csv", "w")
for each_line in content_list:
  if "0" in each_line and "2" in each_line:
     outF.write(each_line)
     outF.write("\n")
outF.close()
```



# How to copy a file into another file using Python? (Copy the contents of a file to another file)
Open the source file in read mode and the destination file in write mode

### Hard code the path
```py
sfile="C:\\Users\\Automation\\Desktop\\random.txt"
dfile="C:\\Users\\Automation\\Downloads\\newrandom.txt"

sfo=open(sfile,'r')
content=sfo.read()
sfo.close()

dfo=open(dfile,'w')
dfo.write(content)
dfo.close()
```

### Ask the file path from user
```py
sfile=input("Enter your source file: ")
dfile=input("Enter your destination file: ")
sfo=open(sfile,'r')
content=sfo.read()
sfo.close()

dfo=open(dfile,'w')
dfo.write(content)
dfo.close()
```






