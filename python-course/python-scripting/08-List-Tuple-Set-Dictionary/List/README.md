# List Data Structure of Python

### bool of list
- boll of empty list ==> False
- boll of non empty list ==> True

```py
my_values1=[2,3,5,'python',10,'10.8','devops']
my_values2=[]
print(my_values1)
print(bool(my_values2))
print(bool(my_values1))

#Output
[2, 3, 5, 'python', 10, '10.8', 'devops']
False
True
```

### String Index
```py
a='Hello Word'
print(a[0])
print(a[1])
print(a[-1])
print(a[-2])
print(a[0:10])
print(a[0:5])

#Output
H
e
d
r
Hello Word
Hello
```
### List Index
```py
my_values1=[2,3,5,'python',10,'3.9.0.9','devops']
print(my_values1,type(my_values1))
print(my_values1[2])
print(my_values1[3])
print(my_values1[3][0])
print(my_values1[3][2])
print(my_values1[-1])
print(my_values1[-1][0])
print(my_values1[5])
print(my_values1[5][0:3])

#Output
[2, 3, 5, 'python', 10, '3.9.0.9', 'devops'] <class 'list'>
5
python
p
t
devops
d
3.9.0.9
3.9
```

### Get the kernel version with index value
```py
a='GNU bash, version 4.2.46(2)-release (x86_64-koji-linux-gnu)'
b=(a.split())
print(b)
print(b[3])
print(b[3][0:5])
kERNEL_VERSION=a.split()[3][0:5]
print(f'The kernel version is: {kERNEL_VERSION}')

#Output
['GNU', 'bash,', 'version', '4.2.46(2)-release', '(x86_64-koji-linux-gnu)']
4.2.46(2)-release
4.2.4
The kernel version is: 4.2.4
```

### Printing a list
```py
my_values1=[2,3,5,'python',10,'3.9.0.9','devops']
print(my_values1)
print(my_values1[:])
print(my_values1[0:])

#Output
[2, 3, 5, 'python', 10, '3.9.0.9', 'devops']
[2, 3, 5, 'python', 10, '3.9.0.9', 'devops']
[2, 3, 5, 'python', 10, '3.9.0.9', 'devops']
```

```py
my_values1=[2,3,5,'python',10,'3.9.0.9','devops']
print(my_values1[1:3])
print(my_values1[4:])
print(my_values1[-2:])
print(my_values1[-3:])

#Output
[3, 5]
[10, '3.9.0.9', 'devops']
['3.9.0.9', 'devops']
[10, '3.9.0.9', 'devops']
```
### Modify index value
- lists are mutable because we can change or modify a list
- strings are immutable because we can't change or modify a list
```py
my_values1=[2,3,5,'python',10,'3.9.0.9','devops']
my_values1[0]=100
print(my_values1)
my_values1[-1]="Devops Course"
print(my_values1)

#Output
[100, 3, 5, 'python', 10, '3.9.0.9', 'devops']
[100, 3, 5, 'python', 10, '3.9.0.9', 'Devops Course']
```

### Help command with list
```py
my_values=[2,3,5,'python',10,'3.9.0.9','devops']
HELP_LIST=dir(my_values)
print(HELP_LIST)
OR
dir(list)

#Output
['append', 'clear', 'copy', 'count', 'extend', 'index', 'insert', 'pop', 'remove', 'reverse', 'sort']
```

### Index command with list
```py
my_values=[2,3,5,'python',10,'3.9.0.9','devops']

print(my_values.index(2))
print(my_values.index('devops'))
print(my_values.index('python'))
print(my_values.index('3.9.0.9'))

#Output
0
6
3
5
```

### Find index in the list
```py
my_values=[2,3,5,'python',10,'3.9.0.9','devops']

if 'devops' in my_values:
	a=my_values.index('devops')
	print(f'It is at index:{a}')
else:
	print("The value is not in the list")
```

### Find index in the list with dublicate value
```py
my_values=[2,3,5,'python',10,'3.9.0.9','devops',2,9,15,2]

print(my_values.index(2))
print(my_values.index(2,3)) # index 2 after 3
print(my_values.index(2,9)) # index 2 after 9

#Output
0
7
10
```
### Count command in list
Use to count the number of time and element is present in the list
```py
my_values=[2,3,5,'python',10,'3.9.0.9','devops',2,9,15,2]

print(my_values.count(2))
print(my_values.count('devops'))
print(my_values.count(20))

#Output
3
1
0
```

### Append command in list
it will add a new element at the end of the list
```py
my_values=[2,3,5,'python',10,'3.9.0.9','devops',2,9,15,2]
my_values.append("This is python scripting")
print(my_values)

#Output
[2, 3, 5, 'python', 10, '3.9.0.9', 'devops', 2, 9, 15, 2, 'This is python scripting']
```

### Insert command in list
This will insert data into a list base on index
```py
my_values=[2,3,5,'python',10,'3.9.0.9','devops',2,9,15,2]
my_values.insert(2,"Hello World")
print(my_values)
my_values.insert(-1,"Hello")
print(my_values)

#Output
[2, 3, 'Hello World', 5, 'python', 10, '3.9.0.9', 'devops', 2, 9, 15, 2]
[2, 3, 'Hello World', 5, 'python', 10, '3.9.0.9', 'devops', 2, 9, 15, 'Hello', 2]
```

### Extend command in list (to combine 2 lists)
```py
my_values1=[2,3,5,'python']
my_values2=[10,'3.9.0.9','devops',2,]
print(my_values1)
print(my_values2)
my_values1.append(my_values2)
print(my_values1)

#Output
[2, 3, 5, 'python']
[10, '3.9.0.9', 'devops', 2]
[2, 3, 5, 'python', [10, '3.9.0.9', 'devops', 2]]
```

```py
my_values1=[2,3,5,'python']
my_values2=[10,'3.9.0.9','devops',2,]
print(my_values1)
print(my_values2)
my_values1.extend(my_values2)
print(my_values1)

#Output
[2, 3, 5, 'python']
[10, '3.9.0.9', 'devops', 2]
[2, 3, 5, 'python', 10, '3.9.0.9', 'devops', 2]
```

### Remove command in list 
```py
my_values=[10,'3.9.0.9',30,'devops',2]
my_values.remove(30)
print(my_values[0:])

#Output
[10, '3.9.0.9', 'devops', 2]
```

```py
my_values=[10,'3.9.0.9',30,'devops',2]
if 30 in my_values:
	my_values.remove(30)
	print(my_values[0:])
else:
	print("The value is not in the list")

#Output
[10, '3.9.0.9', 'devops', 2]
```

```py
my_values=[10,'3.9.0.9',30,'devops',2]
if 35 in my_values:
	my_values.remove(30)
	print(my_values[0:])
else:
	print("The value is not in the list")

#Output
The value is not in the list
```

### Pop command in list 
This will show the list of data that it is going to remove and remove it from the list
```py
my_values=[10,'3.9.0.9',30,'devops',2,'Hello']
my_values.pop(-1)
print(my_values)
my_values.pop(1)
print(my_values)

#Output
[10, '3.9.0.9', 30, 'devops', 2]
[10, 30, 'devops', 2]
```

```py
my_values=[10,'3.9.0.9',30,'devops',2,'Hello']
print(my_values.pop(-1))
print(my_values.pop(0))
print(my_values)

#Output
Hello
10
['3.9.0.9', 30, 'devops', 2]
```

### sort and Reverse command command in list
```py
my_values=[10,2,52,32,5,8,7,42,15,80]
print(my_values)
my_values.sort()
print(my_values)
my_values.reverse()
print(my_values)

#Output
[10, 2, 52, 32, 5, 8, 7, 42, 15, 80]
[2, 5, 7, 8, 10, 15, 32, 42, 52, 80]
[80, 52, 42, 32, 15, 10, 8, 7, 5, 2]
```

### Remove Duplicates From a Python List
```py
mylist = ["a", "b", "a", "c", "c"]
mylist = list(dict.fromkeys(mylist))
print(mylist)

#Output
['a', 'b', 'c']
```

```py
mylist = ["z", "b", "a", "c", "c", "d", "c"]
mylist = list(dict.fromkeys(mylist))
print(mylist)
mylist.sort()
print(mylist)

#Output
['z', 'b', 'a', 'c', 'd']
['a', 'b', 'c', 'd', 'z']
```