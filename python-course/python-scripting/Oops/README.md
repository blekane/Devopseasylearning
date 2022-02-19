# Class in Programing or OOP (object oriented programing)
They are bluepring `(templates)` that we can user to reprente anything in the real world (it should always stsart with `capital later`). It have 2 entites
- The Properties: the properties of a person can be (email, name, age, job title etc.)
- The behaviors: it is what the person can do (he can work, play, talk, run etc.)

## EXAMPLE 
```py
# class
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    # behaviors (method)
    def walk(self):
        print("{0} is walking ............... ".format(self.name))

    def speak(self):
        print("Hello, my name is {0}, and I am {1} year old".format(
            self.name, self.age))

# objects
jhon = Person(
	"jhon", 
	22
)

mariam = Person(
	'mariam'
	, 18
)

#object.method_name (when you want to call the method ousite of a class)
mariam.speak()
mariam.walk()

jhon.speak()
jhon.walk()
```

```py
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

		#self.method_name (when you want to call a method insite of a class)
        self.walk()
        self.speak()

    # behaviors
    def walk(self):
        print("{0} is walking ............... ".format(self.name))

    def speak(self):
        print("Hello, my name is {0}, and I am {1} year old".format(
            self.name, self.age))


# objects
jhon = Person(
    "jhon", 22
)

mariam = Person(
    'mariam', 18
)
```



## EXAMPLE: Execute a method ousite of the class
```py
class Person:
    def __init__(self, name, age, country, Job_title, city, company):
        self.name = name
        self.age = age
        self.country = country
        self.Job_title = Job_title
        self.city = city
        self.company = company

        # self.introduce_self()

    def introduce_self(self):
        print("My name is {0}, I am {1} year old, I am from {2} and I live in {3}. I work at {4} as a {5}.".format(
            self.name,
            self.age,
            self.country,
            self.Job_title,
            self.city,
            self.company
        ))


jhon = Person(
    "Jhon Smith",
    25,
    "Unites of America",
    "DevOps Engineer",
    "Houston Tx",
    "Mercedes-Benz USA"
)
tom = Person(
    "Tom Jonson",
    35,
    "Cameroon",
    "Cloud Engineer",
    "Yaounde",
    "Camtel Comaroon"
)

yan = Person(
    "Yan Vin",
    36,
    "China",
    "Developer",
    "Honkon",
    "AKO China"
)

kempu = Person(
    "Kempu Antoine",
    55,
    "Cameroon",
    "Support Engineer",
    "Douala",
    "MTN Comaroon"
)

jhon.introduce_self()
tom.introduce_self()
yan.introduce_self()
kempu.introduce_self()
```


## EXAMPLE : Execute a method in the class
```py
class Person:
    def __init__(self, name, age, country, Job_title, city, company):
        self.name = name
        self.age = age
        self.country = country
        self.Job_title = Job_title
        self.city = city
        self.company = company

        self.introduce_self()

    def introduce_self(self):
        print("My name is {0}, I am {1} year old, I am from {2} and I live in {3}. I work at {4} as a {5}.".format(
            self.name,
            self.age,
            self.country,
            self.Job_title,
            self.city,
            self.company
        ))


jhon = Person(
    "Jhon Smith",
    25,
    "Unites of America",
    "DevOps Engineer",
    "Houston Tx",
    "Mercedes-Benz USA"
)
tom = Person(
    "Tom Jonson",
    35,
    "Cameroon",
    "Cloud Engineer",
    "Yaounde",
    "Camtel Comaroon"
)

yan = Person(
    "Yan Vin",
    36,
    "China",
    "Developer",
    "Honkon",
    "AKO China"
)

kempu = Person(
    "Kempu Antoine",
    55,
    "Cameroon",
    "Support Engineer",
    "Douala",
    "MTN Comaroon"
)
```

## EXAMPLE with OOP with OOP
```py
class emp:
    def get_name_age_salary(self, name, age, salary):
        self.name = name
        self.age = age
        self.salary = salary
        self.display_details()
        return None

    def display_details(self):
        print(
            f'The name is: {self.name}\nThe age is: {self.age}\nThe salary is: {self.salary}')
        return None


emp1 = emp()
emp2 = emp()

emp1.get_name_age_salary('John', 34, 45000)
emp2.get_name_age_salary('Cliton', 25, 54000)

```

```py
class emp:
    def __init__(self, name, age, salary):
        self.name = name
        self.age = age
        self.salary = salary
        self.display_details()
        return None

    def display_details(self):
        print(
            f'The name is: {self.name}\nThe age is: {self.age}\nThe salary is: {self.salary}')
        return None

emp1 = emp('John', 34, 45000)
emp2 = emp('Cliton', 25, 54000)
```

