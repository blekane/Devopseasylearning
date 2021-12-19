shopping_list = ["milk", "pasta", "eggs", "spam", "bread", "rice"]

for item in shopping_list:
    if item != "spam":
        print("Buy " + item)

print("_" * 60)
for item in shopping_list:
    if item == "spam":
        print("Buy " + item)

print("_" * 60)
for item in shopping_list:
    if item == "spam":
        continue # Continue printing when you find spam
    print("Buy " + item)

print("_" * 60)
for item in shopping_list:
    if item == "spam":
        break # Stop printing when you find spam
    print("Buy " + item)
