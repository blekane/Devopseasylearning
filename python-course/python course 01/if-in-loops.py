numbers1 = [1, 45, 31, 13, 47]

for number in numbers1:
    if number % 8 == 0:
        # reject the list
        print("The numbers are unacceptable")
        break
else:
    print("All those numbers are fine")

numbers2 = [1, 45, 16, 13, 10]
for number in numbers2:
    if number % 8 == 0:
        # reject the list
        print("The numbers are unacceptable")
        break
else:
    print("All those numbers are fine")
