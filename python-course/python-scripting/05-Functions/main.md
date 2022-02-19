## What is __name__ ?

```py
def main():
    print("Hello World!")


if __name__ == "__main__":
    main()
```

```py
import os
import sys
import datetime

def main():
    a = 20
    b = 10
    print(a+b)


if __name__ == "__main__":
    main()
```

```py
import os
import sys
import datetime


def add(a, b):
    print(f"The multiplication of {a} and {b} is {a+b}")
    return None


def mult(a, b):
    print(f"The multiplication of {a} and {b} is {a*b}")
    return None


def sub(a, b):
    print(f"The subtraction of {a} and {b} is {a-b}")
    return None


def main():
    a = 20
    b = 10
    add(a, b)
    sub(a, b)
    mult(a, b)


if __name__ == "__main__":
    main()
```


```py

import os


def chrdir():
    req_path = input("Enter path to change working dir: ")
    print("The current working dir is: ", os.getcwd())
    try:
        os.chdir(req_path)
        print("Now your new working dir is: ", os.getcwd())
    except FileNotFoundError:
        print("Given path is not a valid path. So cant change working directory")
    except NotADirectoryError:
        print("Given path is a file path. So cant change working directory")
    except PermissionError:
        print("Sorry you dont have access for the given path. So cant chagne working directory")
    except Exception as e:
        print(e)


def main():
    chrdir()


if __name__ == "__main__":
    main()
```


```py
from time import sleep

print("This is my file to demonstrate best practices.")


def process_data(data):
    print("Beginning data processing...")
    modified_data = data + " that has been modified"
    sleep(3)
    print("Data processing finished.")
    return modified_data


def read_data_from_web():
    print("Reading data from the Web")
    data = "Data from the web"
    return data


def write_data_to_database(data):
    print("Writing data to a database")
    print(data)


def main():
    data = read_data_from_web()
    modified_data = process_data(data)
    write_data_to_database(modified_data)


if __name__ == "__main__":
    main()
```