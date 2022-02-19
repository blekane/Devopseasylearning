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
