shopping_list = ["milk", "pasta", "eggs", "spam", "bread", "rice"]

print("_" * 60)
for item in shopping_list:
    if item == "spam":
        break #Stop printing when you find spam
    print("Buy " + item)

print("_" * 60)
for item in shopping_list:
    if item == "bread":
        break #Stop printing when you find break
    print("Buy " + item)

print("_" * 60)
a = [1, 2, 3, 4, 5, 6, 7]
for i in a:
    if i == 5:
        break #Stop printing when you find 5
    print("Num " + str(i))

print("_" * 60)
a = [1, 2, 3, 4, 5, 6, 7]
for i in a:
    if i == 5:
        continue #Continue printing when you find 5
    print("Num " + str(i))
