## Platform Module
The Platform module is used to retrieve as much possible information about the platform on which the program is being currently executed.

```py
import platform
dir(platform)
help(platform)

### How to used a platform module?
First import the module

```py
import platform 
import platform as pt # import platform as pt
from platform import * # import all
from platform import system,plaform
```

### Usefull platform module function
```py
import platform

print("{}".format(platform.system()))
print("{}".format(platform.uname()))
print("{}".format(platform.python_version()))
print("{}".format(platform.architecture()))
print("{}".format(platform.version()))
print("{}".format(platform.processor()))
print("{}".format(platform.node()))
```

### EXAMPLE:
```py
#!/usr/local/bin/python3
import os
import platform
if platform.system()=="Windows":
    os.system("cls")
else:
    os.system("clear")
```

```py
if platform.node() == "ubuntu":
    print("Yes")
else:
    print("No")
```