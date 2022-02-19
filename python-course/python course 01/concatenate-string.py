age = 24
print("My age is {0} years".format(age))
print(f"My age is {age} years")

print("There are {0} days in {1}, {2}, {3}, {4}, {5}, {6} and {7}"
      .format(31, "Jan", "Mar", "May", "Jul", "Aug", "Oct", "Dec"))
print("There are {0} days in Jan, Mar, May, Jul, Aug, Oct and Dec".format(31))

print("Jan: {2}, Feb: {0}, Mar: {2}, Apr: {1}, May: {2}, Jun: {1}, Jul: {2}, Sep: {1}, Oct: {2}, Nov: {1}, Dec: {2}"
      .format(28, 30, 31))

print()

print("""Jan: {2}
Feb: {0}
Mar: {2}
Apr: {1}
May: {2}
Jun: {1}
Jul: {2}
Sep: {1}
Oct: {2}
Nov: {1}
Dec: {2}""".format(28, 30, 31))


print(
    """
Jan: {2}
Feb: {0}
Mar: {2}
Apr: {1}
May: {2}
Jun: {1}
Jul: {2}
Sep: {1}
Oct: {2}
Nov: {1}
Dec: {2}
"""
    .format(28, 30, 31))


a = 5
b = 8
c = 10
f = 50

print()
print("the value of a is {0}, the value of b is {1}, the value of c is {2}, and the value of f is {3}".format(
    a, b, c, f))
print(
    f"the value of a is {a}, the value of b is {b}, the value of c is {c}, and the value of f is {f}")

print()
print(f"""the value of a is {a},
the value of b is {b},
the value of c is {c},
and the value of f is {f}""")

print()
print("""the value of a is {0},
the value of b is {1},
the value of c is {2},
and the value of f is {3}""".format(a, b, c, f))
