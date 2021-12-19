print("Please choose your option from the list below:")
print("1:\tLearn Python")
print("2:\tLearn Java")
print("3:\tGo swimming")
print("4:\tHave dinner")
print("5:\tGo to bed")
print("0:\tExit")

while True:
    choice = input()

    if choice == "0":
        print("You chose {} which is exit".format(choice))
        break
    elif choice in "12345":
        print("You chose {}".format(choice))


#-------------------------------------------------------
choice = "-"
while choice != "0":
    if choice in "12345":
        print("You chose {}".format(choice))
    else:
        print("Please choose your option from the list below:")
        print("1:\tLearn Python")
        print("2:\tLearn Java")
        print("3:\tGo swimming")
        print("4:\tHave dinner")
        print("5:\tGo to bed")
        print("0:\tExit")

    choice = input()

#-------------------------------------------------------
def test():
    t = '''Please choose your option from the list below:
    1:\tLearn Python"
    2:\tLearn Java"
    3:\tGo swimming
    4:\tHave dinner
    5:\tGo to bed
    0:\tExit'''

print("Please choose your option from the list below:")
choice = "-"
while choice != "0":
    if choice in "12345":
        print("You chose {}".format(choice))
    else:
        test()
    choice = input()

#-------------------------------------------------------
def test():
    t = '''Please choose your option from the list below:
    1:\tLearn Python"
    2:\tLearn Java"
    3:\tGo swimming
    4:\tHave dinner
    5:\tGo to bed
    0:\tExit'''

    print(t)
test()
