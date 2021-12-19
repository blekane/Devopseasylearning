
## \n means new line
```py
print("Happy Birthday to you!")
print("Happy Birthday to you!\n")
print("Happy  Birthday to you, dear Emey. \n")
print("Happy Birthday to you!,\n")
print("Hope you ha ve a wonderful birthday!")
```

## Comments in python
```py
'''The traditional American school year is designed around a nine-month schedule requiring 180 days in the classroom.
This schedule was established when the United States was still a largely agrarian nation.'''


'''
The traditional American school year is designed around a nine-month schedule requiring 180 days in the classroom.
This schedule was established when the United States was still a largely agrarian nation.
'''

# this code will become a documentation or a text if we start it by 3 apostrophes and end with 3 apostrophes
# the only code here is hello world and it will be printing.
# green colors in python are either strings or comments.

'''name = input("What is your name?: ")
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
question5 = input("Once again thanks.")'''

'''
name = input("Enter your name: ")
print("Hello " + name +"!" )
'''

''' Python will print only hello world'''

print("hello world")

```

## Assingning a text or paragraph in Python
```py
# triple quote is to print the entire text.
# this means we are assigning all this text to introduction

Introduction = '''The traditional American school year is designed around a nine-month schedule requiring 180 days in
the classroom. This schedule was established when the United States was still a largely agrarian nation. Many people
are advocating a shift away from this 9-month school year in favor of year-round education. Some think it will better
prepare them for college, and others think that it will not make a difference if the school year is extended. There
are many points that lead to the conclusion of why the academic school year should be extended with no summer
vacation. It will improve education, benefit low-income families, and will also allow kids to graduate earlier as
well. '''

print(Introduction)
```

## Keywords in Python
```py
# Keywords cannot be use as variable name such as: pass = 'hello'
# Type the comment help() in python and hit enter
# when python bring up the prompt, the keywords and hit enter and all the keywords will be display.
# Here is a list of the Python keywords.  Enter any keyword to get more help.
'''
False               class               from                or
None                continue            global              pass
True                def                 if                  raise
and                 del                 import              return
as                  elif                in                  try
assert              else                is                  while
async               except              lambda              with
await               finally             nonlocal            yield
break               for                 not
'''
```

## How to add two strings
```py
s0 = "Happy" + "holidays"
s1 = "Happy" + " holidays"
s2 = "Happy " + "holidays"
s3 = "Happy, " + "holidays"
s4 = "Happy" + "," + "holidays"
s5 = "Happy" + ", " + "holidays"
print(s0)
print(s1)
print(s2)
print(s3)
print(s4)
print(s5)
```

### Find and replace
```py
# we use comment replace to replace word in the string
# it did not replace it because we have to use a new variable
e = "i am not felling well today and nothing is going well at this moment"
e.replace("and", "because")
print(e)

# we set new variable here
e = "i am not felling well today and nothing is going well at this moment"
g = e.replace("and", "because")
print(g)
```
