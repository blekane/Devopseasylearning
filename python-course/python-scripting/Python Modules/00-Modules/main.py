import variables
import functions


print("My name is {} and I am {} years old".format(variables.NAME, variables.AGE))

if variables.AGE > 18:
    print(f"Hello {variables.NAME}, you can drive")
else:
    print(f"Hello {variables.NAME}, you can't drive")

functions.test()
functions.HELP()
