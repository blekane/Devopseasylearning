## Exit code in python

## EXAMPLE 01
```py
import os
cmd="uptime"
exit_code=os.system(cmd) # this will store the exit code value
if exit_code==0:
    print("Your command was sucessfully executed")
    print("The exit code is: {}".format(exit_code))
else:
    print("You command was failed")
    print("The exit code is: {}".format(exit_code))

# OUTPUT
sh: 1: uptime.: not found
You command was failed
The exit code is: 32512


 05:42:36 up  2:22,  1 user,  load average: 0.13, 0.15, 0.11
Your command was sucessfully executed
The exit code is: 0
```