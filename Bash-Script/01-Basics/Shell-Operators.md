# Unix / Linux - Shell Operators

## There are various operators supported by each shell. 
- Arithmetic Operators
- Relational Operators
- Boolean Operators
- String Operators
- File Test Operators


## Command to check shell operators through CLI
```
man test
```

## 1- Arithmetic Operators
The following arithmetic operators are supported by Bourne Shell.
Assume variable a holds 10 and variable b holds 20 

| Operator | Description | Description |
| :--- | :--- | :--- |
| + (Addition) | Adds values on either side of the operator | `expr $a + $b` will give 30 |
| - (Subtraction) | Subtracts right hand operand from left hand operand | `expr $a - $b` will give -10 |
| * (Multiplication) | Multiplies values on either side of the operator | `expr $a \* $b` will give 200 |
| / (Division) | Divides left hand operand by right hand operand | `expr $b / $a` will give 2 |
| % (Modulus) | Divides left hand operand by right hand operand and returns remainder | `expr $b % $a` will give 0 |
| = (Assignment) | Assigns right operand in left operand | a = $b would assign value of b into a |
| == (Equality) | Compare two numbers, if both are the same then returns true | [ $a == $b ] would return false |
| != (Not Equality) | Compare two numbers, if both are different then return true | [ $a != $b ] would return true |