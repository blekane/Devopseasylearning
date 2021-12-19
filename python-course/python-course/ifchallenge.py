name = input("Please enter your name: ")
age = int(input("How old are you? "))

if 18 <= age < 31:
    print("Welcome to club 18-30 holidays, {0}".format(name))
else:
    print("I'm sorry, our holidays are only for cool people")



name = str(input("Please enter your name: "))
age = int(input("Please enter your age: "))

if age >= 18 and age < 31:
    print(f"Hi {name}, welcome to the holiday!")
else:
    print(f"Sorry {name}, You are not allow to go to the holiday")
