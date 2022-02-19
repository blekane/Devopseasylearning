

### Loop Control statements: break,continue and pass
**Control statements:**
- break
- continue
- pass
The Python Break and Continue Statements are two important statements used to alter the flow of a program in any programming language.
Loops are used to execute certain block of statements for n number of times until the test condition is false. There will be some situations where, we have terminate the loop without executing all the statements. In these situations we can use Python Break statement and Python Continue statements.

**break statement:**
- The break statement terminates the loop ansd the script continue.

**Continue Statement:**
- The continue statement is used to skip the rest of the code inside a loop.

**pass:**
- We use pass statement to write empty loops. Pass is also used for empty control statement, function and classes.

```py
for each in [3,4,56,7,8]:
	print(each)
	if each==56:
		break

#OUTPUT
3
4
56
```

```py
for each in [3,4,56,7,8]:
	break
	print(each)
print("After loop")

#OUTPUT
After loop
```

```py
for each in list(range(1,100)):
	print(each)
	if each==8:
		break

#OUTPUT
1
2
3
4
5
6
7
8
```

### Print first occurance of httpd and stop the loop
```py
paths=['/usr/bin','/usr/bin/httpd','/home/users/xyz/weblogic/config.xml','/usr/bin/httpd']
for each_path in paths:
	if 'httpd' in each_path:
		print(each_path)
		break
print("outside of for loop")

#OUTPUT
/usr/bin/httpd
outside of for loop
```

```py
paths=['/usr/bin','/usr/bin/httpd','/home/users/xyz/weblogic/config.xml']
for each_path in paths:
	print("now working on: ",each_path)
	if 'httpd' in each_path:
		print(each_path)
		break
print("outside of for loop")

#OUTPUT
now working on:  /usr/bin
now working on:  /usr/bin/httpd
/usr/bin/httpd
outside of for loop
```

### Print all httpd path in the list
```py
paths=['/usr/bin','/usr/bin/httpd','/home/users/xyz/weblogic/config.xml','/usr/bin/httpd']
for each_path in paths:
	if 'httpd' in each_path:
		print(each_path)
print("outside of for loop")

#OUTPUT
/usr/bin/httpd
/usr/bin/httpd
outside of for loop
```

```py
cnt=1
while True:
	print(cnt)
	if cnt==10:
		break
	cnt=cnt+1

#OUTPUT
1
2
3
4
5
6
7
8
9
10
```

### Pass condition
It use to avoid geting an error when you do not want to complite a logic immidially 

```py
if True:
	pass
```

```py
paths=['/usr/bin','/usr/bin/httpd','/home/users/xyz/weblogic/config.xml']
for each_path in paths:
	pass
	if 'httpd' in each_path:
		print(each_path)
		break
print("outside of for loop")

#OUTPUT
/usr/bin/httpd
outside of for loop
```

```py
paths=['/usr/bin','/usr/bin/httpd','/home/users/xyz/weblogic/config.xml']
for each_path in paths:
	pass
	if 'httpd' in each_path:
		pass
		break
print("outside of for loop")

#OUTPUT
outside of for loop
```

```py
for each in list(range(1,100)):
	pass
	if each==8:
		break
print("Outside for loop")

#OUTPUT
Outside for loop
```