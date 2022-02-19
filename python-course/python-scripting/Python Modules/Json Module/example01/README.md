
## Example 1
```py
import json


people_string = '''
{
  "people": [
    {
      "name": "Tom Cruise",
      "age": 56,
      "Born At": "Syracuse, NY",
      "Birthdate": "July 3, 1962",
      "photo": "https://jsonformatter.org/img/tom-cruise.jpg"
    },
    {
      "name": "Robert Downey Jr.",
      "age": 53,
      "Born At": "New York City, NY",
      "Birthdate": "April 4, 1965",
      "photo": "https://jsonformatter.org/img/Robert-Downey-Jr.jpg"
    }
  ]
}
'''

data = json.loads(people_string)
print(type(data))

print()
print(data)

print()
print(type(data['people']))

print()
for person in data['people']:
    print(person)

print()
for person in data['people']:
    print(person['name'])
    print(person['Born At'])
    print(person['Birthdate'])
```

```
<class 'dict'>

{'people': [{'name': 'Tom Cruise', 'age': 56, 'Born At': 'Syracuse, NY', 'Birthdate': 'July 3, 1962', 'photo': 'https://jsonformatter.org/img/tom-cruise.jpg'}, {'name': 'Robert Downey Jr.', 'age': 53, 'Born At': 'New York City, NY', 'Birthdate': 'April 4, 1965', 'photo': 'https://jsonformatter.org/img/Robert-Downey-Jr.jpg'}]}

<class 'list'>

{'name': 'Tom Cruise', 'age': 56, 'Born At': 'Syracuse, NY', 'Birthdate': 'July 3, 1962', 'photo': 'https://jsonformatter.org/img/tom-cruise.jpg'}
{'name': 'Robert Downey Jr.', 'age': 53, 'Born At': 'New York City, NY', 'Birthdate': 'April 4, 1965', 'photo': 'https://jsonformatter.org/img/Robert-Downey-Jr.jpg'}

Tom Cruise
Syracuse, NY
July 3, 1962
Robert Downey Jr.
New York City, NY
April 4, 1965
```

## Example 2
```py
import json


people_string = '''
{
  "people": [
    {
      "name": "Tom Cruise",
      "age": 56,
      "Born At": "Syracuse, NY",
      "Birthdate": "July 3, 1962",
      "photo": "https://jsonformatter.org/img/tom-cruise.jpg"
    },
    {
      "name": "Robert Downey Jr.",
      "age": 53,
      "Born At": "New York City, NY",
      "Birthdate": "April 4, 1965",
      "photo": "https://jsonformatter.org/img/Robert-Downey-Jr.jpg"
    }
  ]
}
'''

data = json.loads(people_string)
print(type(data))

print()
for person in data['people']:
    del person['photo']
    print(person)

print()
new_people_string = json.dumps(data, indent=2)
print(new_people_string)
```

```
<class 'dict'>

{'people': [{'name': 'Tom Cruise', 'age': 56, 'Born At': 'Syracuse, NY', 'Birthdate': 'July 3, 1962', 'photo': 'https://jsonformatter.o/src # p
<class 'dict'>

{'name': 'Tom Cruise', 'age': 56, 'Born At': 'Syracuse, NY', 'Birthdate': 'July 3, 1962'}
{'name': 'Robert Downey Jr.', 'age': 53, 'Born At': 'New York City, NY', 'Birthdate': 'April 4, 1965'}

{
  "people": [
    {
      "name": "Tom Cruise",
      "age": 56,
      "Born At": "Syracuse, NY",
      "Birthdate": "July 3, 1962"
    },
    {
      "name": "Robert Downey Jr.",
      "age": 53,
      "Born At": "New York City, NY",
      "Birthdate": "April 4, 1965"
    }
  ]
}
```
