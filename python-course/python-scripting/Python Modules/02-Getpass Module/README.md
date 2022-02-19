## Getpass module
Python getpass module enables to prompt the user for a password without displaying it on the screen. Thus, it will customize the user’s experience.

### Getpass module Help 
```py
import getpass
dir(getpass)
help(getpass)
```

### getuser() function
The` getuser()` function basically returns the corresponding login name of the curent user that is log in.
```py
import getpass
print(getpass.getuser())
```

```py
import getpass
 
LOGIN = getpass.getuser()
print(f"The user that is curently log in is: {LOGIN}")

#OUTPUT
The user that is curently log in is: root
```

## Get DB password
```py
import getpass
 
DB_PASSWORD = input("Enter the DB password: ")
print("The DB password is: {}".format(DB_PASSWORD))

DB_PASSWORD = getpass.getpass()
print("The DB password is: {}".format(DB_PASSWORD))

DB_PASSWORD = getpass.getpass("Enter the DB password: ")
print("The DB password is: {}".format(DB_PASSWORD))

DB_PASSWORD = getpass.getpass(prompt="Enter the DB password: ")
print("The DB password is: {}".format(DB_PASSWORD))

#OUTPUT
Enter the DB password: 12345
The DB password is: 12345
Password: 
The DB password is: 12345as
Enter the DB password: 
The DB password is: 12345ljhtr
Enter the DB password: 
The DB password is: 145878
```

### getpass module with no prompt
```py
import getpass
 
try:
    pass_word = getpass.getpass()
except Exception as E:
    print('There is an Error : ', E)
else:
    print('Password fetched from command prompt :', pass_word)
```

## EXAMOLE
```py
import getpass
 
user = getpass.getuser()
pass_word = getpass.getpass("User's password %s: " % user)
print(user, pass_word)

#OUTPUT
User's password root: 
root 12345
```


