# Introduction to while loop
**While loop:**
- The while loop in Python is used to iterate over a block of code as long as the test expression (condition) is true.
- We generally use this loop when we don't know beforehand, the number of times to iterate.

### Indefiny loop
```py
for each in range(5):
	print('Welcome to loops')
	print('----------------')

#OUTPUT
Welcome to loops
----------------
Welcome to loops
----------------
Welcome to loops
----------------
Welcome to loops
----------------
Welcome to loops
----------------
```

```py
while True:
	print('Welcome to loops')
	print('----------------')

# To stop
while False:
	print('Welcome to loops')
	print('----------------')
```

### Monitor file system for life time
```py
import time
while True:
	print('Monitoring file system usage')
	time.sleep(2)

import time
while False:
	print('Monitoring file system usage')
	time.sleep(2)
```

### Print and stop
```py
cnt=1
while cnt <=5:
	print("hello")
	cnt=cnt+1

#OUTPUT
hello
hello
hello
hello
hello
```