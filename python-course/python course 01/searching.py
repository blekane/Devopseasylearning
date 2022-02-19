shopping_list = ["milk", "pasta", "eggs", "spam", "bread", "rice"]
print(len(shopping_list))

item_to_find = "spam"
found_at = None

# for index in range(6):
for index in range(len(shopping_list)):
    if shopping_list[index] == item_to_find:
        found_at = index
        break

print("Item found at position {}".format(found_at))

#---------------------------------------------------

print("_" * 60)
item_to_find = "cofee"
found_at = None

# for index in range(6):
for index in range(len(shopping_list)):
    if shopping_list[index] == item_to_find:
        found_at = index
        break

print("Item found at position {}".format(found_at))


#---------------------------------------------------
print("_" * 60)
item_to_find = "cofee"
found_at = None

print("_" * 60)
if item_to_find in shopping_list:
    found_at = shopping_list.index(item_to_find)

if found_at is not None:
    print("Item found at position {}".format(found_at))
else:
    print("{} not found".format(item_to_find))
