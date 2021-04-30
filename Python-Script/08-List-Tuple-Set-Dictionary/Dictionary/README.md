# dictionary Data Structure of Python 

### Get Help
```py
my_dir={}
print(dir(my_dir))
#OUTPUT
['clear', 'copy', 'fromkeys', 'get', 'items', 'keys', 'pop', 'popitem', 'setdefault', 'update', 'values']
```

### Define a dictionary
```py
my_dir={'fruit':'apple','animal':'fox',1:'one','two':2}
print(my_dir)
print(bool(my_dir))
my_dir1={}
print(my_dir1,type(my_dir1))
print(bool(my_dir1))

#OUTPUT
{'fruit': 'apple', 'animal': 'fox', 1: 'one', 'two': 2}
True
{} <class 'dict'>
False
```

### Printing Keys from the dictionary

```py
my_dir={'fruit':'apple','animal':'fox',1:'one','two':2}

print(my_dir.keys())
print(my_dir.values())
print(my_dir.items())

#OUTPUT
dict_keys(['fruit', 'animal', 1, 'two'])
dict_values(['apple', 'fox', 'one', 2])
dict_items([('fruit', 'apple'), ('animal', 'fox'), (1, 'one'), ('two', 2)])


```py
my_dir={'fruit':'apple','animal':'fox',1:'one','two':2}
print(my_dir.get('fruit'))
print(my_dir['animal'])
print(my_dir.get(1))
print(my_dir.get('two'))

print('---------')

for each_value in my_dir:
  # print('---------')
  print(each_value)

#OUTPUT
apple
fox
one
2
---------
fruit
animal
1
two
```

### Printing Keys and value from the dictionary

```py
my_dir={'fruit':'apple','animal':'fox',1:'one','two':2}

print('---------')

for key in my_dir:
  print(key)

print('---------')

 # we want keys plus values
for key, value in my_dir.items():
    print(key, value)

#OUTPUT
---------
fruit
animal
1
two
---------
fruit apple
animal fox
1 one
two 2
```

### Add a new key: if the value the key is in the dictionary already, the value will be modified
```py
my_dir={'fruit':'apple','animal':'fox',1:'one','two':2}

my_dir['three']=3
print(my_dir)
my_dir['three']=50
print(my_dir)

#OUTPUT
{'fruit': 'apple', 'animal': 'fox', 1: 'one', 'two': 2, 'three': 3}
{'fruit': 'apple', 'animal': 'fox', 1: 'one', 'two': 2, 'three': 50}
```

### Copy a dictionary
Python will assign a new memory location to a new value and they will have different ID
```py
my_dir={'fruit':'apple','animal':'fox',1:'one','two':2}

y=my_dir.copy()
print(y)
print(my_dir)
print(id(y),id(my_dir))
print(id(y))
print(id(my_dir))
print('')
y['script']='python'
print(y)
print('')
print(my_dir)

#OUTPUT
{'fruit': 'apple', 'animal': 'fox', 1: 'one', 'two': 2}
{'fruit': 'apple', 'animal': 'fox', 1: 'one', 'two': 2}
2336533653248 2336533653056
2336533653248
2336533653056

{'fruit': 'apple', 'animal': 'fox', 1: 'one', 'two': 2, 'script': 'python'}

{'fruit': 'apple', 'animal': 'fox', 1: 'one', 'two': 2}
```


### Update command 
It will combine 2 dictionary
```py
my_dir1={'fruit':'apple','animal':'fox',1:'one','two':2}
my_dir2={'email':'t@gmail.com','phone':'3426663','address':'123 Holly View'}

print(my_dir1)
print(my_dir2)
my_dir1.update(my_dir2)
print('')
print(my_dir1)

#OUTPUT
{'fruit': 'apple', 'animal': 'fox', 1: 'one', 'two': 2}
{'email': 't@gmail.com', 'phone': '3426663', 'address': '123 Holly View'}

{'fruit': 'apple', 'animal': 'fox', 1: 'one', 'two': 2, 'email': 't@gmail.com', 'phone': '3426663', 'address': '123 Holly View'}
```

### Pop command in dictionary
Pop remove items base on key pair representation
```py
my_dir1={'fruit':'apple','animal':'fox',1:'one','two':2}
my_dir2={'email':'t@gmail.com','phone':'3426663','address':'123 Holly View'}

my_dir1.update(my_dir2)
print(my_dir1)

my_dir1.pop('address')
print(my_dir1)

my_dir1.pop('email')
print(my_dir1)

#OUTPUT
{'fruit': 'apple', 'animal': 'fox', 1: 'one', 'two': 2, 'email': 't@gmail.com', 'phone': '3426663', 'address': '123 Holly View'}
{'fruit': 'apple', 'animal': 'fox', 1: 'one', 'two': 2, 'email': 't@gmail.com', 'phone': '3426663'}
{'fruit': 'apple', 'animal': 'fox', 1: 'one', 'two': 2, 'phone': '3426663'}
```

### Fromkeys command in dictionary
it use to create a dictionary with keys only
```py
keys={'a','b','c','e'}
new_dic=dict.fromkeys(keys)
print(new_dic)
new_dic['a']='Devops'
print(new_dic)

#OUTPUT
{'c': None, 'b': None, 'e': None, 'a': None}
{'c': None, 'b': None, 'e': None, 'a': 'Devops'}
```

# key equal student
```py
student = {'name': 'Jhon',  'age': 25, 'courses': ['Math', 'CompSci']}
# this means print the student age if it exist otherwise print not found
print(student.get('courses', 'Not found'))
# this means print the student age if it exist otherwise print not found
print(student.get('age', 'Not found'))
print(student.get('name'))
print(student.get('paul'))
# this means print the student age if it exist otherwise print not found
print(student.get('name', 'Not found'))

# this is because we do not have the student phone number yet
print(student.get('phone', 'Not found'))
print(student.get('phone'))
print(student.get('phone', 'Student phone number do not exist'))

#OUTPUT
{'name': 'Jhon', 'age': 25, 'courses': ['Math', 'CompSci']}
['Math', 'CompSci']
['Math', 'CompSci']
25
Jhon
None
Jhon
Not found
None
Student phone number do not exist
```

### Convert Dictionary into list
```py
dic={'name': 'Lucas Djo', 'age': 26, 'courses': 'EDUC 1300, ENGL 1301, Mathematics, Histry', 'phone': '832 897 8633', 'address': '10645 Beechnut St Apt 1017, Houston Tx 77072', 'email': 'leonardtia@gemail.com', 'ID': '208714557'}
print(dic)
dic2=list(dic)
print('')
print(dic2)

#OUTPUT
{'name': 'Lucas Djo', 'age': 26, 'courses': 'EDUC 1300, ENGL 1301, Mathematics, Histry', 'phone': '832 897 8633', 'address': '10645 Beechnut St Apt 1017, Houston Tx 77072', 'email': 'leonardtia@gemail.com', 'ID': '208714557'}

['name', 'age', 'courses', 'phone', 'address', 'email', 'ID']
```





```py
student = {'name': 'Jhon',  'age': 25, 'courses': ['Math', 'CompSci']}
student['phone'] = '832 897 8633'
print("")
print(student)
print("")
print(student.get('address', 'Not found'))
print("")
student['address'] = '10645 Beechnut St Apt 1017, Houston Tx 77072'
print(student.get('address', 'Not found'))
print("")
print(student)
print("")
print(student.get('email', 'Not found'))
print("")
student['email'] = 'leonardtia@gemail.com'
print(student['email'])
print(student)
print("")
# we can update a student name if the name exist already
student['name'] = 'Leonard Lucas'
print(student['name'])
print("")
# how can we update multiple things at the same time? we use update
student.update({'name': 'Lucas Djo', 'age': 26, 'courses': 'EDUC 1300, ENGL 1301, Mathematics, Histry', 'ID': '208714557'})

'''
OR
dic_2={'name': 'Lucas Djo', 'age': 26, 'courses': 'EDUC 1300, ENGL 1301, Mathematics, Histry', 'ID': '208714557'}
student.update(dic_2)
'''
print("")
print(student)
print("")
print(student['courses'])
print("")
# How to deltte a key
del student['courses']
print("")
print(student)
print("")
# How to print the number of keys in the dictionary?
print(len(student))
print("")
# How po all the keys in the dictionary?
print(student.keys())
print("")
# how to print only the values of the keys?
print(student.values())
print("")
print(student.items())
print("")

# Another method to print student keys is:
for key in student:
    print(key)
print("")

 # we want keys plus values
for key, value in student.items():
    print(key, value)


#OUTPUT
{'name': 'Jhon', 'age': 25, 'courses': ['Math', 'CompSci'], 'phone': '832 897 8633'}

Not found

10645 Beechnut St Apt 1017, Houston Tx 77072

{'name': 'Jhon', 'age': 25, 'courses': ['Math', 'CompSci'], 'phone': '832 897 8633', 'address': '10645 Beechnut St Apt 1017, Houston Tx 77072'}

Not found

leonardtia@gemail.com
{'name': 'Jhon', 'age': 25, 'courses': ['Math', 'CompSci'], 'phone': '832 897 8633', 'address': '10645 Beechnut St Apt 1017, Houston Tx 77072', 'email': 'leonardtia@gemail.com'}

Leonard Lucas


{'name': 'Lucas Djo', 'age': 26, 'courses': 'EDUC 1300, ENGL 1301, Mathematics, Histry', 'phone': '832 897 8633', 'address': '10645 Beechnut St Apt 1017, Houston Tx 77072', 'email': 'leonardtia@gemail.com', 'ID': '208714557'}

EDUC 1300, ENGL 1301, Mathematics, Histry


{'name': 'Lucas Djo', 'age': 26, 'phone': '832 897 8633', 'address': '10645 Beechnut St Apt 1017, Houston Tx 77072', 'email': 'leonardtia@gemail.com', 'ID': '208714557'}

6

dict_keys(['name', 'age', 'phone', 'address', 'email', 'ID'])

dict_values(['Lucas Djo', 26, '832 897 8633', '10645 Beechnut St Apt 1017, Houston Tx 77072', 'leonardtia@gemail.com', '208714557'])

dict_items([('name', 'Lucas Djo'), ('age', 26), ('phone', '832 897 8633'), ('address', '10645 Beechnut St Apt 1017, Houston Tx 77072'), ('email', 'leonardtia@gemail.com'), ('ID', '208714557')])

name
age
phone
address
email
ID

name Lucas Djo
age 26
phone 832 897 8633
address 10645 Beechnut St Apt 1017, Houston Tx 77072
email leonardtia@gemail.com
ID 208714557
```