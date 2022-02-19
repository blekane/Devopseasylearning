## Python switch case statement examples

## EXAMPLE 1
```py
# creating a function for switch statement
def switch(case):

    # checks if the argument matches first case
    if case == 1:
        print("Monday")

    # checks if the argument matches second case
    elif case == 2:
        print("Tuesday")

    # checks if the argument matches third case
    elif case == 3:
        print("Wednesday")

    # checks if the argument matches fourth case
    elif case == 4:
        print("Thursday")

    # checks if the argument matches fifth case
    elif case == 5:
        print("Friday")

    # checks if the argument matches sixth case
    elif case == 6:
        print("Saturday")

    # checks if the argument matches seventh case
    elif case == 7:
        print("Sunday")

    else:
        print("Please enter number between 1-7")


# calling function
switch(4)
switch(9)
```

## EXAMPLE 2
```py
NUMBER = input("Please enter case between 1-7: ")

def switch(case):

    if case == "1":
        print("Monday")
        exit()

    elif case == "2":
        print("Tuesday")
        exit()

    elif case == "3":
        print("Wednesday")
        exit()

    elif case == "4":
        print("Thursday")
        exit()

    elif case == "5":
        print("Friday")
        exit()

    elif case == "6":
        print("Saturday")
        exit()

    elif case == "7":
        print("Sunday")
        exit()

    else:
        print("Invalid Option")


switch(NUMBER)
```

## EXAMPLE 3
```py
#!/usr/bin/env python3
import os


def HELP():
    HELP = '''
        *********************************
        *       1==> cpu                *
        *       2==> Memory             *
        *       3==> Os version         *
        *       4==> processes          *
        *       5==> system bits        *
        *       6==> mount points       *
        *       7==> ip address         *
        *       8==> Hostname           *
        *       9==> Kernel version     *
        *       10==> update OS         *
        *********************************

    '''
    print(HELP)


HELP()


ANSWER = input("Enter your choice from the table between (1 - 10): ")


def switch(case):
    if case == "1":
        os.system("nproc")
        exit()

    elif case == "2":
        os.system("free -h")
        exit()

    elif case == "3":
        os.system("ps -ef")
        exit()

    elif case == "4":
        os.system("ps -ef")
        exit()

    elif case == "5":
        os.system("getconf LONG_BIT")
        exit()

    elif case == "6":
        os.system("df -h")
        exit()

    elif case == "7":
        os.system("ip a")
        exit()

    elif case == "8":
        os.system("hostname")
        exit()

    elif case == "9":
        os.system("uname -r")
        exit()

    elif case == "10":
        os.system("apt update -y")
        exit()

    else:
        print("Invalid Option")


switch(ANSWER)
```