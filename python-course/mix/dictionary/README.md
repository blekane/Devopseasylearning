
```py
# key equal student
student = {'name': 'Jhon', 'age': 25, 'courses': ['Math', 'CompSci']}
print(student)
print(student['courses'])
print(student['name'])
print(student['age'])

# this means print the student age if it exist otherwise print not found
print(student.get('courses', 'Not found'))

# this means print the student age if it exist otherwise print not found
print(student.get('age', 'Not found'))

# this means print the student age if it exist otherwise print not found
print(student.get('name', 'Not found'))

# if we use this, it will return none  instead of a nd error
print(student.get('phone'))
print(student.get('phone', 'Student phone number do not exist'))

student['phone'] = '832 897 8633'
print(student['phone'])

print(student)

print(student.get('address', 'Not found'))
student['address'] = '10645 Beechnut St Apt 1017, Houston Tx 77072'
print(student.get('address', 'Not found'))

print(student.get('email', 'Not found'))
student['email'] = 'leonardtia@gemail.com'
print(student['email'])
print(student)

# we can update a student name if the name exist already
student['name'] = 'Leonard Lucas'
print(student['name'])

# how can we update multiple things at the same time? we use update
student.update({'name': 'Lucas Djo', 'age': 26, 'courses': 'EDUC 1300, ENGL 1301, Mathematics, History', 'ID': '208714557'})
print(student)
print(student['courses'])

# How to delete a key
del student['courses']

# How to print the number of keys in the dictionary?
print(len(student))

# How po all the keys in the dictionary?
print(student.keys())

# how to print only the values of the keys?
print(student.values())

# Another method to print student keys is:
for key in student:
    print(key)

# we want keys plus values
for key, value in student.items():
    print(key, value)

```
