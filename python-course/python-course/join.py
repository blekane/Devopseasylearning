list1 = ['1','2','3','4']
s = "-"
s = s.join(list1)
print(s)


list1 = ['g','e','e','k', 's']
print("".join(list1))


myDict = {"name": "John", "country": "Norway"}
mySeparator = "TEST"
x = mySeparator.join(myDict)
print(x)


myTuple = ["John", "Peter", "Vicky"]
x = "#".join(myTuple)
print(x)
for i in myTuple:
    print("#".join(myTuple))


