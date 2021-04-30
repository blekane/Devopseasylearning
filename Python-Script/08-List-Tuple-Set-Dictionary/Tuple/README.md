# Tuple Data Structure of Python 
- Strings and tuples are immutable. This means you defined it, you can't modified it again.
- you can just convert your tuple into list and work with so that you can take advantage with the list commands. and then convert it back.

### Help command with list
```py
my_tuple=(2,3,5,'python',10,'3.9.0.9','devops')
HELP_LIST=dir(my_tuple)
print(HELP_LIST)
or
dir(tuple)

#Output
['count', 'index']
```

### Defined Tuple 
```py
my_tuple1=(2, 3, 5, 'python', 10, '3.9.0.9', 'devops')
my_tuple=2, 3, 5, 'python', 10, '3.9.0.9', 'devops'
print(my_tuple)
print(my_tuple,type(my_tuple))

#Output
(2, 3, 5, 'python', 10, '3.9.0.9', 'devops')
(2, 3, 5, 'python', 10, '3.9.0.9', 'devops') <class 'tuple'>
```

### Print Tuple
```py
my_tuple1=(2,3,5,'python',10,'3.9.0.9','devops')
my_tuple2=()
print(my_tuple1)
print(bool(my_tuple2))
print(bool(my_tuple1))

#Output
(2, 3, 5, 'python', 10, '3.9.0.9', 'devops')
False
True
```

### Convert tuple into list 
you can just convert your tuple into list and work with so that you can take advantage with the list commands. and then convert it back
```py
my_tuple=(2,3,5,'python',10,'3.9.0.9','devops')
my_list=list(my_tuple)
print(my_tuple)
print(my_list)

#Output
(2, 3, 5, 'python', 10, '3.9.0.9', 'devops')
[2, 3, 5, 'python', 10, '3.9.0.9', 'devops']
```

```py
my_list=[2, 3, 5, 'python', 10, '3.9.0.9', 'devops']
my_tuple=tuple(my_list)
print(my_list)
print(my_tuple)

#Output
[2, 3, 5, 'python', 10, '3.9.0.9', 'devops']
(2, 3, 5, 'python', 10, '3.9.0.9', 'devops')
```