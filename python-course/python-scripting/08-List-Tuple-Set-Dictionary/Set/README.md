# Set Data Structure of Python 
- it good with statistic and math
- set are called unorder colection of data because it will not print your data in order

### Help command with list
```py
my_set={2,3,5,10,8,10,2,7,9,7,2}
HELP_LIST=dir(my_set)
print(HELP_LIST)
or
dir(set)

#Output
['add', 'clear', 'copy', 'difference', 'difference_update', 'discard', 'intersection', 'intersection_update', 'isdisjoint', 'issubset', 'issuperset', 'pop', 'remove', 'symmetric_difference', 'symmetric_difference_update', 'union', 'update']
```

### Set will remove duplicate by default
set are called unorder colection of data because it will not print your data in order
```py
my_set={2,3,5,10,8,10,2,7,9,7,2}
my_set2=({})
print(my_set)
print(bool(my_set))
print(bool(my_set2))

#Output
{2, 3, 5, 7, 8, 9, 10}
True
False
```

### Convert set into a list
```py
my_set={2,3,5,10,8,10,2,7,9,7,2}
my_list=list(my_set)
print(my_set)
print(my_list)

#Output
{2, 3, 5, 7, 8, 9, 10}
[2, 3, 5, 7, 8, 9, 10]
```
