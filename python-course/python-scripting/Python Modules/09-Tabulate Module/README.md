### Install the module
```
python3 -m pip install tabulate

or

pip3 install tabulate
```

### Example
```py
#!/usr/bin/env python3

from tabulate import tabulate

all_data = [["Roll Number","Student name","Marks"],
            [1,"Sasha",34],
            [2,"Richard",36],
            [3,"Judy",20],
            [4,"Lori",39],
            [5,"Maggie",40]]

print()
table1 = tabulate(all_data)
print(table1)

print()
table2 = tabulate(all_data,headers='firstrow')
print(table2)

print()
print(tabulate(all_data,headers='firstrow',tablefmt='grid'))

print()
print(tabulate(all_data,headers='firstrow',tablefmt='fancy_grid'))
```

```
-----------  ------------  -----
Roll Number  Student name  Marks
1            Sasha         34
2            Richard       36
3            Judy          20
4            Lori          39
5            Maggie        40
-----------  ------------  -----

  Roll Number  Student name      Marks
-------------  --------------  -------
            1  Sasha                34
            2  Richard              36
            3  Judy                 20
            4  Lori                 39
/src # p

-----------  ------------  -----
Roll Number  Student name  Marks
1            Sasha         34
2            Richard       36
3            Judy          20
4            Lori          39
5            Maggie        40
-----------  ------------  -----

  Roll Number  Student name      Marks
-------------  --------------  -------
            1  Sasha                34
            2  Richard              36
            3  Judy                 20
            4  Lori                 39
/src # p

-----------  ------------  -----
Roll Number  Student name  Marks
1            Sasha         34
2            Richard       36
3            Judy          20
4            Lori          39
5            Maggie        40
-----------  ------------  -----

  Roll Number  Student name      Marks
-------------  --------------  -------
            1  Sasha                34
            2  Richard              36
            3  Judy                 20
            4  Lori                 39
            5  Maggie               40

+---------------+----------------+---------+
|   Roll Number | Student name   |   Marks |
+===============+================+=========+
|             1 | Sasha          |      34 |
+---------------+----------------+---------+
|             2 | Richard        |      36 |
+---------------+----------------+---------+
|             3 | Judy           |      20 |
+---------------+----------------+---------+
|             4 | Lori           |      39 |
+---------------+----------------+---------+
|             5 | Maggie         |      40 |
+---------------+----------------+---------+

╒═══════════════╤════════════════╤═════════╕
│   Roll Number │ Student name   │   Marks │
╞═══════════════╪════════════════╪═════════╡
│             1 │ Sasha          │      34 │
├───────────────┼────────────────┼─────────┤
│             2 │ Richard        │      36 │
├───────────────┼────────────────┼─────────┤
│             3 │ Judy           │      20 │
├───────────────┼────────────────┼─────────┤
│             4 │ Lori           │      39 │
├───────────────┼────────────────┼─────────┤
│             5 │ Maggie         │      40 │
╘═══════════════╧════════════════╧═════════╛
```
