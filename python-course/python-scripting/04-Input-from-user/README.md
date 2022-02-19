### Exercise 1
```py
name = input("Enter your name: ")
print("Hello " + name +"!" )

name = input("Enter your name: ")
print(f"Hello {name}!")
```

### Exercise 2
```py
name = input("Enter your name: ")
age = input("Enter your age: ")
print(name)
print(age)

name = input("Enter your name: ")
age = input("Enter your age: ")
print(f"\n {name} \n {age}")
```

### Exercise 3
```py
name = input("Enter your name: ")
age = input("Enter your age: ")
print("Hello " + name +"! you are " + age )

name = input("Enter your name: ")
age = input("Enter your age: ")
print(f"Hello {name}! you are {age} year old." )
```

### Exercise 4
```py
name = input("Enter your name: ")
age = input("Enter your age: ")
address = input("Enter your address: ")
print("Hello " + name + "! you are " + age + " and your address is " + address)

name = input("Enter your name: ")
age = input("Enter your age: ")
address = input("Enter your address: ")
print(f"Hello {name}! you are {age} and your address is {address}")


name = input("Enter your name: ")
age = input("Enter your age: ")
address = input("Enter your address: ")
phone = input("Enter your phone number: ")
print("Hello " + name + "! Just to make a recap:" + " you are " + age + ", your address is " + address + 
", and your phone number is " + phone +
". Thank so much " + name + " for this personal informations. We really appreciate it.")

name = input("Enter your name: ")
age = input("Enter your age: ")
address = input("Enter your address: ")
phone = input("Enter your phone number: ")
print(f"Hello  {name}! Just to make a recap: you are {age} year old, your address is {address}, and your phone number is {phone}. \nThank so much {name} for this personal informations. We really appreciate it.")
```

### Exercise 5
```py
name = input("Enter your name: ")
age = input("Enter your age: ")
address = input("Enter your address: ")
phone = input("Enter your phone number: ")
print(f"Hello {name}! \nJust to make a recap: \n\t- You are {age} \n\t- Your address is {address} \n\t- Your phone number is {phone} \nThank so much {name} for this personal informations. We really appreciate it.")

# Output
Hello Tia! 
Just to make a recap: 
	- You are 20 
	- Your address is 555 Holly View 
	- Your phone number is 854 665 3555 
Thank so much Tia for this personal informations. We really appreciate it.
```

### Exercise 6
```py
name = input("What is your name?: ")
print("Nice to meet you " + name + "!")
age = input("Your age? ")
print("So, you are already " + age + " years old, " + name + "!")
color = input("What is your favorite  color?: ")
print("So your favorite color is " + color + "!" + " That is my favorite color too, " + name)

name = input("What is your name?: ")
print("Nice to meet you " + name + "!")
age = input("Your age? ")
print(f"So, you are already {age} years old {name}!")
color = input("What is your favorite  color?: ")
print(f"So your favorite color is {color}! That is my favorite color too,{name}")
```

### Exercise 7
```py
name = input("What is your name?: ")
print("Nice to meet you " + name + "!" + " I am Leo from the USA." )
country = input("Where are you from?: ")
print("wow! " + country + " is a beautiful country. Isn't is?")
answer = input("Answer: ")
print("I really love you country because everything there is well organize.")
question1 = input("So where do you live know?: ")
print("Really! This is amazing we are neighbors!")
question3 = input("How long have you been here " + question1 + "?:")
print("Wow! you just live here " + question3 + " like my friend Jhon." +  " He have been here only for " +
      question3 + " in the USA too.")
question4 = input("Do you mind if i have your phone number?: ")
print("Thank so much " + name + " i really appreciate it. mine is 860 862 1352. I will call you tomorrow.")
print("Good bye!")
question5 = input("Once again thanks.")


name = input("What is your name?: ")
print(f"Nice to meet you {name}! I am Leo from the USA." )
country = input("Where are you from?: ")
print(f"wow! {country} is a beautiful country. Isn't is?")
answer = input("Answer: ")
print(f"I really love you country because everything there is well organize.")
question1 = input("So where do you live know?: ")
print(f"Really! This is amazing we are neighbors!")
question3 = input("How long have you been here {question1}? ")
print(f"Wow! you just live here {question3} like my friend Jhon. He have been here only for {question3} in the USA too.")
question4 = input(f"Do you mind if I have your phone number?: ")
print(f"Thank so much {name} I really appreciate it. Mine is 860 862 1352. I will call you tomorrow.")
print(f"Good bye!")
question5 = input("Once again thanks.")
```

### Exercise 8: with else statement and with a float
```py
name = input("Enter your name: ")
print("Hello " + name +"!" )
print("Hope all is well. ")

# Ask for temperature outside and use if statement.
# We are going to use float here because the temperation might a float number
# if we do not use floot and the temperature is a floot number, we might have unexpected result.

temperature = float(input("What is the temperature outside " + name + "?:"))
if temperature > 70:
    print("Wear shorts ")
    print("Enjoy your day " + name + "!")
else:
    print("Wear long pants " + name + "!")
    print("Get some exercises outside.")
bye = input("Bye bye " + name + "!")
# this program will not fail if we put float numbers such as 7.3 or 65.8

# -----------------------------------------------------------------------------
name = input("Enter your name: ")
print(f"Hello {name}!" )
print(f"Hope all is well.")
temperature = float(input(f"What is the temperature outside {name}?: "))

if temperature > 70:
    print(f"Wear shorts ")
    print(f"Enjoy your day {name}!")
else:
    print(f"Wear long pants {name}!")
    print(f"Get some exercises outside.")
bye = input(f"Bye bye {name}!")
```

### Exercise 9: with else statement and without a float
```py
name = input("Enter your name: ")
print("Hello " + name +"!" )
print("Hope all is well. ")

# Ask for temperature outside and use if statement.
# We are going to use float here because the temperation might a float number
# if we do not use floot and the temperature is a floot number, we might have unexpected result.

temperature = input("What is the temperature outside " + name + "?:")
if temperature > 70:
    print(" Wear shorts ")
    print("Enjoy your day " + name + "!")
else:
    print("Wear long pants " + name + "!")
    print("Get some exercises outside.")

# this program will give and error because the temperature can be either a number or a float.
# This means we must use the word float before input.
```

## Covid
```py
def COVID():

    FIRST_NAME = input("Enter the first name: ")
    LAST_NAME = input("Enter the last name: ")
    AGE = input("Enter age: ")
    FEVER = input("Do you have fever (y or n)?: ")
    COUGH = input("Do you have a cough? (y or n): ")
    BREATHING = input("Do you have any difficulty breathing? (y or n): ")
    CONTACT = input(
        "Have you been in contact with someone who has been tested positive with the Coronavirus? (y or n): ")
    TRAVEL = input(
        "Did you travel outside the United States for the past 2 weeks? (y or n): ")
    HOUSE = input("Is anyone in your house cough, fever, difficulty breathing or have been in contact with someone who has been tested positive for Coronavirus? (y or n): ")

    if FEVER == "n" and COUGH == "n" and BREATHING == "n" and CONTACT == "n" and TRAVEL == "n" and HOUSE == "n":
        print("Hello {} {}, You  are {} years old, and you do not need to be tested for COVID-19".format(FIRST_NAME, LAST_NAME, AGE))

    elif FEVER == "y" or COUGH == "y" or BREATHING == "y" or CONTACT == "y" or TRAVEL == "y" or HOUSE == "y":
        print("Hello {} {}, You  are {} years old, and You need to be tested for COVID-19".format(FIRST_NAME, LAST_NAME, AGE))

    else:
        print("Hello {} {}, please check your answers".format(
            FIRST_NAME, LAST_NAME))


COVID()
```