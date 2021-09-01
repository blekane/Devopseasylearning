

## Example 1:
```groovy
print "Enter you name: "
def NAME = System.console().readLine()
println("Hello $NAME")

print "Enter first number: "
def NUM1 = System.console().readLine().toInteger()
print "Enter second number: "
def NUM2 = System.console().readLine().toInteger()
println("$NUM1 and $NUM2")
println "$NUM1 + $NUM2 = "+(NUM1 + NUM2)
```

**OUTPUT:**
```
Hello tia
Enter first number: 10
Enter second number: 30
10 and 30
10 + 30 = 40
```

## Example 2:
```groovy
print("Enter the first name: ")
def FIRST_NAME = System.console().readLine().toString() 
print("Enter the last name: ")
def LAST_NAME = System.console().readLine().toString()
print("Enter age: ")
def AGE = System.console().readLine().toString()
print("Do you have fever (y or n)?: ")
def FEVER = System.console().readLine().toString()
print("Do you have a cough? (y or n): ")
def COUGH = System.console().readLine().toString()
print("Do you have any difficulty breathing? (y or n): ")
def BREATHING = System.console().readLine().toString()
print("Have you been in contact with someone who has been tested positive with the Coronavirus? (y or n): ")
def CONTACT = System.console().readLine().toString()
print("Did you travel outside the United States for the past 2 weeks? (y or n): ")
def TRAVEL = System.console().readLine().toString()
print("Is anyone in your house cough, fever, difficulty breathing or have been in contact with someone who has been tested positive for Coronavirus? (y or n): ")
def  HOUSE = System.console().readLine().toString()


if (("$FEVER" == "y") && ("$COUGH" == "y") && ("$BREATHING" == "y") && ("$CONTACT" == "y") && ("$TRAVEL" == "y") && ("$HOUSE" == "y")) {
    println("Hello $FIRST_NAME $LAST_NAME, You need to be tested for COVID-19")
}

else if (("$FEVER" == "n") || ("$COUGH" == "n") || ("$BREATHING" == "n") || ("$CONTACT" == "n") || ("$TRAVEL" == "n") || ("$HOUSE" == "n")) {
    println("Hello $FIRST_NAME $LAST_NAME, You do not need to be tested for COVID-19")
}

else {
   println("Please $FIRST_NAME $LAST_NAME, please check your answers")
}
```