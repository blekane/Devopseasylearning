available_exits = ["north", "south", "east", "west"]

chosen_exit = " "
while chosen_exit not in available_exits:
    chosen_exit = input("Please choose a direction: ")
print("You exit direction is {}".format(chosen_exit))

print("_" * 60)
chosen_exit = "south"
while chosen_exit not in available_exits:
    chosen_exit = input("Please choose a direction: ")
print("You exit direction is {}".format(chosen_exit))

print("_" * 60)
chosen_exit = " "
if chosen_exit not in available_exits:
    chosen_exit = input("Please choose a direction: ")
    print("You exit direction is {}".format(chosen_exit))


print("_" * 60)
chosen_exit = " "
if chosen_exit not in available_exits:
    print("Unnom {}".format(chosen_exit))


#--------------------------------------------------------
available_exits = ["north", "south", "east", "west"]
chosen_exit = ""
while chosen_exit not in available_exits:
    chosen_exit = input("Please choose a direction: ")
    if chosen_exit.casefold() == "quit":
        print("Game over")
        break
else:
    print("aren't you glad you got out of there")


available_exits = ["north", "south", "east", "west"]
chosen_exit = ""
while chosen_exit not in available_exits:
    chosen_exit = input("Please choose a direction: ")
    if chosen_exit.casefold() == "quit":
        print("Game over")
        break
print("aren't you glad you got out of there")
