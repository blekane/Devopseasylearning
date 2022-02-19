#in operator working

list1= [1, 2, 3, 4, 5]
string1= "My name is AskPython"
tuple1=(11, 22, 33, 44)

print(5 in list1) #True
print("is" in string1) #True
print(88 in tuple1) #False

print("_" * 60)

#in and not in operator working on Dictionary. Pytho will check only the keys and not the values

dict1 = {1: "one", 2: "two", 3: "three", 4: "four"}

print("one" in dict1)
print(1 in dict1)
print("one" not in dict1)

print(3 in dict1)
print(3 not in dict1)

print(5 in dict1)
print(5 not in dict1)
