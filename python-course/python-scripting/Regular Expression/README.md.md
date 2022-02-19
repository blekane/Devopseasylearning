## Regular Expressions in Python - ALL You Need To Know [here](https://www.python-engineer.com/posts/regular-expressions/)


## Performing matches with compiled objects
Once we have our pattern, we can search for this pattern in the text / string that we want to look up. RE has 4 different methods:

- `match():` Determine if the RE matches at the beginning of the string.
- `search():` Scan through a string, looking for any location where this RE matches.
- `findall():` Find all substrings where the RE matches, and returns them as a list.
- `finditer():` Find all substrings where the RE matches, and returns them as an iterator.

## finditer methods (This will print match objects with index position)
RE is case sentitive. It didn't print `ABC`
```py
import re

test_string = '123abc456789abc123ABC'
pattern = re.compile(r'abc')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)
    print(test_string[3:6])
    print(test_string[12:15])

# OR
import re

test_string = '123abc456789abc123ABC'
matches = re.finditer(r'abc', test_string)
for match in matches:
    print(match)

#OUTPUT
<re.Match object; span=(3, 6), match='abc'>
abc
abc
<re.Match object; span=(12, 15), match='abc'>
abc
abc
```

## findall methods (This will print just a string)
```py
import re

test_string = '123abc456789abc123ABC'
pattern = re.compile(r'abc')
matches = pattern.findall(test_string)
for match in matches:
    print(match)

#OUTPUT
abc
abc
```

## findall methods (This will a string only at the beginning)
```py
import re

test_string = '123abc456789abc123ABC'
pattern = re.compile(r'abc')
match = pattern.match(test_string)
print(match)

#OUTPUT
None # because there is not abc at the beginning

import re

test_string = 'abc123abc456789abc123ABC'
pattern = re.compile(r'abc')
match = pattern.match(test_string)
print(match)
print(test_string[0:3])

#OUTPUT
<re.Match object; span=(0, 3), match='abc'>
abc
```

## search methods (This will return the first match)
```py
import re

test_string = '123abc456789abc123ABC'
pattern = re.compile(r'abc')
match = pattern.search(test_string)
print(match)
print(test_string[3:6])

#OUTPUT
<re.Match object; span=(3, 6), match='abc'>
abc
```

## Methods on a Match object
- `group():` Return the string matched by the RE
- `start():` Return the starting position of the match
- `end():` Return the ending position of the match
- `span():` Return a tuple containing the (start, end) positions of the match

## span (this will print the tuple)
```py
import re

test_string = '123abc456789abc123ABC'
pattern = re.compile(r'abc')
matches = pattern.finditer(test_string)
for match in matches:
    print(match.span())

#OUTPUT
(3, 6)
(12, 15)
```

## start (this will print start index position)
```py
import re

test_string = '123abc456789abc123ABC'
pattern = re.compile(r'abc')
matches = pattern.finditer(test_string)
for match in matches:
    print(match.start())

#OUTPUT
3
12
```

## start (this will print end index position)
```py
import re

test_string = '123abc456789abc123ABC'
pattern = re.compile(r'abc')
matches = pattern.finditer(test_string)
for match in matches:
    print(match.end())

#OUTPUT
6
15
```

## start (this will print actual string of the match)
```py
import re

test_string = '123abc456789abc123ABC'
pattern = re.compile(r'abc')
matches = pattern.finditer(test_string)
for match in matches:
    print(match.group(1))

#OUTPUT
abc
abc
```

## Meta characters
Metacharacters are characters with a special meaning:
All meta characters: `. ^ $ * + ? { } [ ] \ | ( )`
Meta characters need need to be escaped (with ) if we actually want to search for the char.

- `.` Any character (except newline character) "he..o"
- `^` Starts with `"^hello"`
- `$` Ends with `"world$"`
- `*` Zero or more occurrences `"aix*"`
- `+` One or more occurrences `"aix+"`
- `{ }` Exactly the specified number of occurrences "al{2}"
- `[]` A set of characters "[a-m]"
- `\` Signals a special sequence (can also be used to escape special characters) "\d"
- `|` Either or "falls|stays"
- `( )` Capture and group


### `.` Any character (except newline character) "he..o"
```py
import re

test_string = 'python-engineer.com'
pattern = re.compile(r'\.')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

#OUTPUT
<re.Match object; span=(15, 16), match='.'>
```

### `^` Starts with `"^hello"`
```py
import re

test_string = 'python-engineer.com'
pattern = re.compile(r'^python')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

#OUTPUT
<re.Match object; span=(0, 6), match='python'>
```

### `$` Ends with `"world$"`
```py
import re

test_string = 'python-engineer.com'
pattern = re.compile(r'engineer.com$')
matches = pattern.findall(test_string)
for match in matches:
    print(match)

#OUTPUT
engineer.com
```

### `[]` A set of characters or number or underscore. We can also specify a range here `"[a-f]"` ===> "[abcdf]", `[a-z]`, `[0-9]`, `[a-zA-Z]`, `[a-zA-Z0-9_]`
```py
import re

test_string = 'hello 123_'
pattern = re.compile(r'[a-z]')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

print()
test_string = 'hello 123_'
pattern = re.compile(r'[23]')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

print()
test_string = 'hello 123_'
pattern = re.compile(r'[0-9]')  # (r'\d') ==>> all the digits
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

print()
test_string = 'hello 123_'
pattern = re.compile(r'[0-9]')  # (r'\d') ==>> all the digits
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

print()
test_string = 'helloHOLLO 123_'
pattern = re.compile(r'[A-Z]')  # (r'\d') ==>> all the digits
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

print()
test_string = 'helloHOLLO 123_'
pattern = re.compile(r'[a-zA-Z]')  # (r'\d') ==>> all the digits
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

print()
test_string = 'helloHOLLO 123_'
pattern = re.compile(r'[a-zA-Z0-9]')  # (r'\d') ==>> all the digits
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

print()
test_string = 'helloHOLLO 123_'
pattern = re.compile(r'[a-zA-Z0-9_]')  # (r'\d') ==>> all the digits
matches = pattern.finditer(test_string)
for match in matches:
    print(match)


#OUTPUT
<re.Match object; span=(0, 1), match='h'>
<re.Match object; span=(1, 2), match='e'>
<re.Match object; span=(2, 3), match='l'>
<re.Match object; span=(3, 4), match='l'>
<re.Match object; span=(4, 5), match='o'>

<re.Match object; span=(7, 8), match='2'>
<re.Match object; span=(8, 9), match='3'>

<re.Match object; span=(6, 7), match='1'>
<re.Match object; span=(7, 8), match='2'>
<re.Match object; span=(8, 9), match='3'>

<re.Match object; span=(6, 7), match='1'>
<re.Match object; span=(7, 8), match='2'>
<re.Match object; span=(8, 9), match='3'>

<re.Match object; span=(5, 6), match='H'>
<re.Match object; span=(6, 7), match='O'>
<re.Match object; span=(7, 8), match='L'>
<re.Match object; span=(8, 9), match='L'>
<re.Match object; span=(9, 10), match='O'>

<re.Match object; span=(0, 1), match='h'>
<re.Match object; span=(1, 2), match='e'>
<re.Match object; span=(2, 3), match='l'>
<re.Match object; span=(3, 4), match='l'>
<re.Match object; span=(4, 5), match='o'>
<re.Match object; span=(5, 6), match='H'>
<re.Match object; span=(6, 7), match='O'>
<re.Match object; span=(7, 8), match='L'>
<re.Match object; span=(8, 9), match='L'>
<re.Match object; span=(9, 10), match='O'>

<re.Match object; span=(0, 1), match='h'>
<re.Match object; span=(1, 2), match='e'>
<re.Match object; span=(2, 3), match='l'>
<re.Match object; span=(3, 4), match='l'>
<re.Match object; span=(4, 5), match='o'>
<re.Match object; span=(5, 6), match='H'>
<re.Match object; span=(6, 7), match='O'>
<re.Match object; span=(7, 8), match='L'>
<re.Match object; span=(8, 9), match='L'>
<re.Match object; span=(9, 10), match='O'>
<re.Match object; span=(11, 12), match='1'>
<re.Match object; span=(12, 13), match='2'>
<re.Match object; span=(13, 14), match='3'>

<re.Match object; span=(0, 1), match='h'>
<re.Match object; span=(1, 2), match='e'>
<re.Match object; span=(2, 3), match='l'>
<re.Match object; span=(3, 4), match='l'>
<re.Match object; span=(4, 5), match='o'>
<re.Match object; span=(5, 6), match='H'>
<re.Match object; span=(6, 7), match='O'>
<re.Match object; span=(7, 8), match='L'>
<re.Match object; span=(8, 9), match='L'>
<re.Match object; span=(9, 10), match='O'>
<re.Match object; span=(11, 12), match='1'>
<re.Match object; span=(12, 13), match='2'>
<re.Match object; span=(13, 14), match='3'>
<re.Match object; span=(14, 15), match='_'>
```


```py
import re
dates = '''
01.04.2020

2020.04.01

2020-04-01
2020-05-23
2020-06-11
2020-07-11
2020-08-11

2020/04/02

2020_04_04
2020_04_04
'''

print('all dates with a character in between')
pattern = re.compile(r'\d\d\d\d.\d\d.\d\d')
matches = pattern.finditer(dates)
for match in matches:
    print(match)

print()
print('only dates with - or . in between')
# no escape for the . here in the set
pattern = re.compile(r'\d\d\d\d[-.]\d\d[-.]\d\d')
matches = pattern.finditer(dates)
for match in matches:
    print(match)

print()
print('only dates with - or . or _ in between')
# no escape for the . here in the set
pattern = re.compile(r'\d{4}[-._]\d{2}[-._]\d{2}')
matches = pattern.finditer(dates)
for match in matches:
    print(match)

print()
print('only dates with - or . or _ or / in between')
# no escape for the . here in the set
pattern = re.compile(r'\d{4}[-._/]\d{2}[-._/]\d{2}')
matches = pattern.finditer(dates)
for match in matches:
    print(match)

#OUTPUT
all dates with a character in between
<re.Match object; span=(13, 23), match='2020.04.01'>  
<re.Match object; span=(25, 35), match='2020-04-01'>  
<re.Match object; span=(36, 46), match='2020-05-23'>  
<re.Match object; span=(47, 57), match='2020-06-11'>  
<re.Match object; span=(58, 68), match='2020-07-11'>  
<re.Match object; span=(69, 79), match='2020-08-11'>  
<re.Match object; span=(81, 91), match='2020/04/02'>  
<re.Match object; span=(93, 103), match='2020_04_04'> 
<re.Match object; span=(104, 114), match='2020_04_04'>

only dates with - or . in between
<re.Match object; span=(13, 23), match='2020.04.01'>
<re.Match object; span=(25, 35), match='2020-04-01'>
<re.Match object; span=(36, 46), match='2020-05-23'>
<re.Match object; span=(47, 57), match='2020-06-11'>
<re.Match object; span=(58, 68), match='2020-07-11'>
<re.Match object; span=(69, 79), match='2020-08-11'>

only dates with - or . or _ in between
<re.Match object; span=(13, 23), match='2020.04.01'>
<re.Match object; span=(25, 35), match='2020-04-01'>
<re.Match object; span=(36, 46), match='2020-05-23'>
<re.Match object; span=(47, 57), match='2020-06-11'>
<re.Match object; span=(58, 68), match='2020-07-11'>
<re.Match object; span=(69, 79), match='2020-08-11'>
<re.Match object; span=(93, 103), match='2020_04_04'>
<re.Match object; span=(104, 114), match='2020_04_04'>

only dates with - or . or _ or / in between
<re.Match object; span=(13, 23), match='2020.04.01'>
<re.Match object; span=(25, 35), match='2020-04-01'>
<re.Match object; span=(36, 46), match='2020-05-23'>
<re.Match object; span=(47, 57), match='2020-06-11'>
<re.Match object; span=(58, 68), match='2020-07-11'>
<re.Match object; span=(69, 79), match='2020-08-11'>
<re.Match object; span=(81, 91), match='2020/04/02'>
<re.Match object; span=(93, 103), match='2020_04_04'>
<re.Match object; span=(104, 114), match='2020_04_04'>
```



## More Metacharacters / Special Sequences
A special sequence is a \ followed by one of the characters in the list below, and has a special meaning:

- `\d` :Matches any decimal digit; this is equivalent to the class `[0-9]`.
- `\D` : Matches any non-digit character; this is equivalent to the class `[^0-9]`.
- `\s` : Matches any whitespace character;
- `\S` : Matches any non-whitespace character;
- `\w` : Matches any alphanumeric (word) character; this is equivalent to the class [a-zA-Z0-9_].
- `\W` : Matches any non-alphanumeric character; this is equivalent to the class [^a-zA-Z0-9_].
- `\b` Returns a match where the specified characters are at the beginning or at the end of a word r"\bain" - r"ain\b"
- `\B` Returns a match where the specified characters are present, but NOT at the beginning (or at the end) - of a word r"\Bain" r"ain\B"
- `\A` Returns a match if the specified characters are at the beginning of the string "\AThe"
- `\Z` Returns a match if the specified characters are at the end of the string "Spain\Z"


## `\d` :Matches any decimal digit; this is equivalent to the class [0-9].
```py
import re

test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\d')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

# OUTPUT
<re.Match object; span=(6, 7), match='1'>
<re.Match object; span=(7, 8), match='2'>      
<re.Match object; span=(8, 9), match='3'> 
```

```py
import re

test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\d\d\d')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

# OUTPUT
<re.Match object; span=(6, 9), match='123'>
```

```py
import re

test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\d{3}')
matches = pattern.findall(test_string)
for match in matches:
    print(match)

# OUTPUT
123
```

### `\D` : Matches any non-digit character; this is equivalent to the class `[^0-9]`.
```py
import re

test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\D')
matches = pattern.findall(test_string)
for match in matches:
    print(match)

# OUTPUT
h
e
l
l
o

_

h
e
y
h
o

h
o
h
e
y
```

### `\s` : Matches any whitespace character;
```py
import re

test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\s')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

# OUTPUT
<re.Match object; span=(5, 6), match=' '>
<re.Match object; span=(10, 11), match=' '>
<re.Match object; span=(16, 17), match=' '>
```

### `\S` : Matches any non-whitespace character;
```py
import re

test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\S')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

#OUTPUT
<re.Match object; span=(0, 1), match='h'>
<re.Match object; span=(1, 2), match='e'>
<re.Match object; span=(2, 3), match='l'>
<re.Match object; span=(3, 4), match='l'>
<re.Match object; span=(4, 5), match='o'>
<re.Match object; span=(6, 7), match='1'>
<re.Match object; span=(7, 8), match='2'>
<re.Match object; span=(8, 9), match='3'>
<re.Match object; span=(9, 10), match='_'>
<re.Match object; span=(11, 12), match='h'>
<re.Match object; span=(12, 13), match='e'>
<re.Match object; span=(13, 14), match='y'>
<re.Match object; span=(14, 15), match='h'>
<re.Match object; span=(15, 16), match='o'>
<re.Match object; span=(17, 18), match='h'>
<re.Match object; span=(18, 19), match='o'>
<re.Match object; span=(19, 20), match='h'>
<re.Match object; span=(20, 21), match='e'>
<re.Match object; span=(21, 22), match='y'>
```

### \w : Matches any alphanumeric (word) and character; this is equivalent to the class [a-zA-Z0-9_].
```py
import re

test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\w')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

#OUTPUT
<re.Match object; span=(0, 1), match='h'>
<re.Match object; span=(1, 2), match='e'>  
<re.Match object; span=(2, 3), match='l'>  
<re.Match object; span=(3, 4), match='l'>  
<re.Match object; span=(4, 5), match='o'>  
<re.Match object; span=(6, 7), match='1'>  
<re.Match object; span=(7, 8), match='2'>  
<re.Match object; span=(8, 9), match='3'>  
<re.Match object; span=(9, 10), match='_'> 
<re.Match object; span=(11, 12), match='h'>
<re.Match object; span=(12, 13), match='e'>
<re.Match object; span=(13, 14), match='y'>
<re.Match object; span=(14, 15), match='h'>
<re.Match object; span=(15, 16), match='o'>
<re.Match object; span=(17, 18), match='h'>
<re.Match object; span=(18, 19), match='o'>
<re.Match object; span=(19, 20), match='h'>
<re.Match object; span=(20, 21), match='e'>
<re.Match object; span=(21, 22), match='y'>
```

### \W : Matches any non-alphanumeric character; this is equivalent to the class [^a-zA-Z0-9_].
This will just print while spaces
```py
import re

test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\W')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

# OUTPUT
<re.Match object; span=(5, 6), match=' '>
<re.Match object; span=(10, 11), match=' '>
<re.Match object; span=(16, 17), match=' '>
```

### `\b` Returns a match where the specified characters are at the beginning a block or a word and `\B` Returns a match where the specified characters are present, but NOT at the beginning of a block or a word

```py
import re

test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\bhello')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

print()
test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\bhey')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

print()
test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\Bhey')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

print()
test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\B3_')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

print()
test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\B123_')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

print()
test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\b123_')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

print()
test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\b1')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)


#OUTPUT
<re.Match object; span=(0, 5), match='hello'>

<re.Match object; span=(11, 14), match='hey'>  

<re.Match object; span=(19, 22), match='hey'>  

<re.Match object; span=(8, 10), match='3_'>    


<re.Match object; span=(6, 10), match='123_'>  

<re.Match object; span=(6, 7), match='1'> 
```


### `\A` Returns a match if the specified characters are at the beginning of the string "\AThe". This is equivalent to `^` and `\Z` Returns a match if the specified characters are at the end of the string "Spain\Z". This is equivalent to `$`
```py
import re

test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\Ahe')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'\Ahello')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

print()
test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'ey\Z')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

test_string = 'hello 123_ heyho hohey'
pattern = re.compile(r'hohey\Z')
matches = pattern.finditer(test_string)
for match in matches:
    print(match)

# OUTPUT 
<re.Match object; span=(0, 2), match='he'>
<re.Match object; span=(0, 5), match='hello'>  

<re.Match object; span=(20, 22), match='ey'>   
<re.Match object; span=(17, 22), match='hohey'>
```


## Quantifier
- `*` : 0 or more
- `+` : 1 or more
- `?` : 0 or 1, used when a character can be optional
- `{4}` : exact number
- `{4,6}` : range numbers (min, max)

```py
import re
my_string = '21.1230'
pattern = re.compile(r'\d')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
my_string = '21.1230'
pattern = re.compile(r'\d*')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
my_string = '21.1230'
pattern = re.compile(r'\d{2}.\d*')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
my_string = '21.1230'
pattern = re.compile(r'\d{2}.\d{2}')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
my_string = '21.1230'
pattern = re.compile(r'\d+.\d+')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
my_string = '21.1230'
pattern = re.compile(r'\d*.\d*')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
my_string = '21.1230'
pattern = re.compile(r'\d{1,2}.\d{1,3}')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
my_string = '210.1230'
pattern = re.compile(r'\d{1,3}.\d{1,2}')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
my_string = '_210'  # look for a digit that has underscore ifront of it
pattern = re.compile(r'_\d')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
my_string = '_214850'  # look for a digit that has underscore ifront of it
pattern = re.compile(r'_\d{2}')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
# ? just means we are not sure if we have underscore infront of the digit
my_string = '_214850'
pattern = re.compile(r'_?\d{2}')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
# ? just means we are not sure if we have underscore infront of the digit
my_string = '_21_48_50'
pattern = re.compile(r'_?\d{2}')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
# ? just means we are not sure if we have underscore infront of the digit
my_string = '_21_48_50'
pattern = re.compile(r'_\d{2}')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

#OUTPUT
<re.Match object; span=(0, 1), match='2'>
<re.Match object; span=(1, 2), match='1'>
<re.Match object; span=(3, 4), match='1'>
<re.Match object; span=(4, 5), match='2'>
<re.Match object; span=(5, 6), match='3'>
<re.Match object; span=(6, 7), match='0'>

<re.Match object; span=(0, 2), match='21'>
<re.Match object; span=(2, 2), match=''>
<re.Match object; span=(3, 7), match='1230'>
<re.Match object; span=(7, 7), match=''>

<re.Match object; span=(0, 7), match='21.1230'>

<re.Match object; span=(0, 5), match='21.12'>

<re.Match object; span=(0, 7), match='21.1230'>

<re.Match object; span=(0, 7), match='21.1230'>

<re.Match object; span=(0, 6), match='21.123'>

<re.Match object; span=(0, 6), match='210.12'>

<re.Match object; span=(0, 2), match='_2'>

<re.Match object; span=(0, 3), match='_21'>

<re.Match object; span=(0, 3), match='_21'>
<re.Match object; span=(3, 5), match='48'>
<re.Match object; span=(5, 7), match='50'>

<re.Match object; span=(0, 3), match='_21'>
<re.Match object; span=(3, 6), match='_48'>
<re.Match object; span=(6, 9), match='_50'>

<re.Match object; span=(0, 3), match='_21'>
<re.Match object; span=(3, 6), match='_48'>
<re.Match object; span=(6, 9), match='_50'>
```

## Conditions

## Example 01
```py
import re
my_string = """
Hello world
12225
2020-05-20
Mr David
Mrs Simpson
Mr. Brown
Ms Smith
Mr. T
"""

pattern = re.compile(r'Mr\s\w+')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
pattern = re.compile(r'Mrs\s\w+')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
pattern = re.compile(r'Mr\.?\s\w+')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
pattern = re.compile(r'(Mr|Mrs|Ms)\.?\s\w+')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
pattern = re.compile(r'(Mr|Mrs|Ms)\s\w+')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

print()
pattern = re.compile(r'(Mr|Mrs|Ms)\.?\s\w+')
matches = pattern.finditer(my_string)
for match in matches:
    print(match)

#OUTPUT
<re.Match object; span=(30, 38), match='Mr David'>

<re.Match object; span=(39, 50), match='Mrs Simpson'>

<re.Match object; span=(30, 38), match='Mr David'>
<re.Match object; span=(51, 60), match='Mr. Brown'>
<re.Match object; span=(70, 75), match='Mr. T'>

<re.Match object; span=(30, 38), match='Mr David'>
<re.Match object; span=(39, 50), match='Mrs Simpson'>
<re.Match object; span=(51, 60), match='Mr. Brown'>
<re.Match object; span=(61, 69), match='Ms Smith'>
<re.Match object; span=(70, 75), match='Mr. T'>

<re.Match object; span=(30, 38), match='Mr David'>
<re.Match object; span=(39, 50), match='Mrs Simpson'>
<re.Match object; span=(61, 69), match='Ms Smith'>

<re.Match object; span=(30, 38), match='Mr David'>
<re.Match object; span=(39, 50), match='Mrs Simpson'>
<re.Match object; span=(51, 60), match='Mr. Brown'>
<re.Match object; span=(61, 69), match='Ms Smith'>
<re.Match object; span=(70, 75), match='Mr. T'>
```

## Example 02
```py
import re
emails = """
Mr Simpson
Mrs Simpson
Mr. Brown
Ms Smith
Mr. T
Hello world
12225
2020-05-20
pythonengineer@gmail.com
Python-engineer@gmx.de
python-engineer123@my-domain.org
"""

pattern = re.compile('[a-zA-Z1-9-]+@')
matches = pattern.finditer(emails)
for match in matches:
    print(match)

print()
pattern = re.compile('[a-zA-Z1-9-]+@[a-zA-Z-]+\.[a-zA-Z]+')
matches = pattern.finditer(emails)
for match in matches:
    print(match)

print()
pattern = re.compile('[a-zA-Z1-9-]*@[a-zA-Z-]*\.[a-zA-Z]*')
matches = pattern.finditer(emails)
for match in matches:
    print(match)

print()
pattern = re.compile('[a-zA-Z1-9-]+@[a-zA-Z-]+\.(com|de)')
matches = pattern.finditer(emails)
for match in matches:
    print(match)

print()
pattern = re.compile('[a-zA-Z1-9-]*@[a-zA-Z-]*\.(com|de|org)')
matches = pattern.finditer(emails)
for match in matches:
    print(match)

print()
pattern = re.compile('([a-zA-Z1-9-]+)@([a-zA-Z-]+)\.([a-zA-Z]+)')
matches = pattern.finditer(emails)
for match in matches:
    print(match)


#OUTPUT
<re.Match object; span=(78, 93), match='pythonengineer@'>
<re.Match object; span=(103, 119), match='Python-engineer@'>
<re.Match object; span=(126, 145), match='python-engineer123@'>

<re.Match object; span=(78, 102), match='pythonengineer@gmail.com'>
<re.Match object; span=(103, 125), match='Python-engineer@gmx.de'>
<re.Match object; span=(126, 158), match='python-engineer123@my-domain.org'>

<re.Match object; span=(78, 102), match='pythonengineer@gmail.com'>
<re.Match object; span=(103, 125), match='Python-engineer@gmx.de'>
<re.Match object; span=(126, 158), match='python-engineer123@my-domain.org'>

<re.Match object; span=(78, 102), match='pythonengineer@gmail.com'>
<re.Match object; span=(103, 125), match='Python-engineer@gmx.de'>

<re.Match object; span=(78, 102), match='pythonengineer@gmail.com'>
<re.Match object; span=(103, 125), match='Python-engineer@gmx.de'>
<re.Match object; span=(126, 158), match='python-engineer123@my-domain.org'>

<re.Match object; span=(78, 102), match='pythonengineer@gmail.com'>
<re.Match object; span=(103, 125), match='Python-engineer@gmx.de'>
<re.Match object; span=(126, 158), match='python-engineer123@my-domain.org'>
```

## Grouping
```py
print()
pattern = re.compile('([a-zA-Z1-9-]+)@([a-zA-Z-]+)\.([a-zA-Z]+)')
matches = pattern.finditer(emails)
for match in matches:
    # print(match)

    print(match.group(0))

#OUTPUT
pythonengineer@gmail.com
Python-engineer@gmx.de
python-engineer123@my-domain.org
```

```py
print()
pattern = re.compile('([a-zA-Z1-9-]+)@([a-zA-Z-]+)\.([a-zA-Z]+)')
matches = pattern.finditer(emails)
for match in matches:
    # print(match)

    print(match.group(0))

#OUTPUT
pythonengineer
Python-engineer
python-engineer123
```

```py
print()
pattern = re.compile('([a-zA-Z1-9-]+)@([a-zA-Z-]+)\.([a-zA-Z]+)')
matches = pattern.finditer(emails)
for match in matches:
    # print(match)

    print(match.group(0))

#OUTPUT
gmail
gmx
my-domain
```

```py
print()
pattern = re.compile('([a-zA-Z1-9-]+)@([a-zA-Z-]+)\.([a-zA-Z]+)')
matches = pattern.finditer(emails)
for match in matches:
    # print(match)

    print(match.group(0))

#OUTPUT
com
de
org
```
## Modifying strings
```py
import re
my_string = 'abc123ABCDEF123abc'
pattern = re.compile(r'123')  # no escape for the . here in the set
matches = pattern.split(my_string)
print(matches)
print(matches[0])
print(matches[1])
print(matches[2])

# OUTPUT
['abc', 'ABCDEF', 'abc']
abc
ABCDEF
abc
```

```py
import re
my_string = '5.11.0-43-generic'
pattern = re.compile(r'-43')  # no escape for the . here in the set
matches = pattern.split(my_string)
print(matches)
print(matches[0])

if matches[0] >= "5":
    print("Kernel version is: {}".format(matches[0]))

# OUTPUT  
['5.11.0', '-generic']
5.11.0
Kernel version is: 5.11.0
```

```py
import re
my_string = "hello world, you are the best world"
pattern = re.compile(r'world')
subbed_string = pattern.sub(r'planet', my_string)
print(subbed_string)

#OUTPUT
hello planet, you are the best planet
```

```py
urls = """
http://python-engineer.com
https://www.python-engineer.org
http://www.pyeng.net
"""
pattern = re.compile(r'https?://(www\.)?(\w|-)+\.\w+')
pattern = re.compile(r'https?://(www\.)?([a-zA-Z-]+)(\.\w+)')
matches = pattern.finditer(urls)
for match in matches:
    #print(match)
    print(match.group()) # 0
    #print(match.group(1))
    #print(match.group(2))
    print(match.group(3))
    
# substitute using back references to replace url + domain name
subbed_urls = pattern.sub(r'\2\3', urls)
print(subbed_urls)

#OUTPUT
http://python-engineer.com
.com
https://www.python-engineer.org
.org
http://www.pyeng.net
.net

python-engineer.com
python-engineer.org
pyeng.net 
```

https://www.youtube.com/watch?v=KJG1dETacLI