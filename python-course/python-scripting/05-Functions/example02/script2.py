import script1


def mult(a, b):
    print(f"The multiplication of {a} and {b} is {a*b}")
    return None


def main():
    a = 20
    b = 10
    mult(a, b)
    script1.addition(a, b)
    script1.sub(a, b)


if __name__ == "__main__":
    main()
