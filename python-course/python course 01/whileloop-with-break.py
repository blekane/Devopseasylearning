available_exits = ["north", "south", "east", "west"]

chosen_exit = input("Please choose a direction: ")
while chosen_exit in available_exits:
    print(f"{chosen_exit} exist")
    break

chosen_exit = ""
while chosen_exit not in available_exits:
    chosen_exit = input("Please choose a direction: ")
    if chosen_exit.casefold() == "quit": #casefold allow us to quit the progrm with `quit` and `Quit`
        print("Game over")
        break
print("aren't you glad you got out of there")


