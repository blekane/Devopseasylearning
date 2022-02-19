day = "Saturday"
temperature = 30
raining= False

if (day == "Saturday" and temperature > 27) or not raining:
    print("Go swimming")
else:
    print("Learn Python")

## not True is False
## not False is True

if (day == "Saturday" and temperature > 27) and not raining:
    print("Go swimming")
else:
    print("Learn Python")

print("_" * 50)
raining2= True
if (day == "Saturday" and temperature > 27) and not raining2:
    print("Go swimming")
else:
    print("Learn Python")



if 0:
    print("True")
else:
    print("False")

name = input("Please enter your name: ")
# if name:
if name != "":
    print("Hello, {}".format(name))
else:
    print("Are you the man with no name?")

