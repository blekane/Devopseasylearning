string1 = "he's "
string2 = "probably "
string3 = "pining "
string4 = "for the "
string5 = "fjords"

print(string1 + string2 + string3 + string4 + string5)
print(f"{string1} {string2} {string3} {string4} {string5}")

print("he's " "probably " "pining " "for the " "fjords")

print("Hello " * 5)

today = "friday"
print("day" in today)       # True
print("fri" in today)       # True
print("friday" in today)    # True
print("thur" in today)      # False
print("parrot" in today)    # False
