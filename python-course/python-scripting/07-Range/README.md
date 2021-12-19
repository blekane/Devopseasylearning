## Range in Python
It is going to generate intergers as a list. It start with 0 by default

### Complete range() function
**range() function:**
- The range() function generates the integer numbers between the given start integer to the
stop integer, which is generally used to iterate over with for Loop.
- Python3 range() accepts an integer and returns a range object, which is nothing but a
sequence of integers.

**Syntax:**
- range (start, stop[, step])
- range() takes three arguments.
- Out of the three 2 arguments are optional. I.e., Start and Step are the optional arguments.
- Default value of start is 0 and step is 1

```py
a = list(range(6))
print(a)

for x in a:
	print(x)

# Output
[0, 1, 2, 3, 4, 5]
0
1
2
3
4
5
```

```py
a = list(range(5,12))
print(a)

for x in a:
	print(x)

# Output
[5, 6, 7, 8, 9, 10, 11]
5
6
7
8
9
10
11
```


