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
