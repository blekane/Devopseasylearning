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

**Example:**
```sh
#!/bin/sh
 
a=10
b=20
 
val=`expr $a + $b`
echo "a + b : $val"
 
val=`expr $a - $b`
echo "a - b : $val"
 
val=`expr $a \* $b`
echo "a * b : $val"
 
val=`expr $b / $a`
echo "b / a : $val"
 
val=`expr $b % $a`
echo "b % a : $val"
 
if [ $a == $b ]
then
   echo "a is equal to b"
fi
 
if [ $a != $b ]
then
   echo "a is not equal to b"
fi
```

**RESULT:**
```
a + b : 30
a - b : -10
a * b : 200
b / a : 2
b % a : 0
a is not equal to b
```
The following points need to be considered while working with relational operators −
There must be spaces between the operators and the expressions. For example, 2+2 is not correct; it should be written as 2 + 2.


## 2- Relational Operators
Bourne Shell supports the following relational operators that are specific to numeric values. These operators do not work for string values unless their value is numeric.

For example, following operators will work to check a relation between `10` and `20` as well as in between `10` and `20` but not in between "ten" and "twenty". Assume variable a holds `10` and variable b holds `20`

| Operator | Description | Description |
| :--- | :--- | :--- |
| -eq | Checks if the value of two operands are equal; if yes, then the condition becomes true | [ $a -eq $b ] is not true |
| -ne | Checks if the value of two operands are equal or not; if values are not equal, then the condition becomes true | [ $a -eq $b ] is not true |
| -gt | Checks if the value of the left operand is greater than the value of right operand; if yes, then the condition becomes true | [ $a -gt $b ] is not true |
| -lt | Checks if the value of the left operand is less than the value of the right operand; if yes, then the condition becomes true | [ $a -lt $b ] is true |
| -ge | Checks if the value of left operand is greater than or equal to the value of right operand; if yes, then the condition becomes true | [ $a -ge $b ] is not true |
| -le | Checks if the value of left operand is less than or equal to the value of right operand; if yes, then the condition becomes true | [ $a -le $b ] is true |

**Example:**
```sh
#!/bin/sh
 
a=10
b=20
 
if [ $a -eq $b ]
then
   echo "$a -eq $b : a is equal to b"
else
   echo "$a -eq $b: a is not equal to b"
fi
 
if [ $a -ne $b ]
then
   echo "$a -ne $b: a is not equal to b"
else
   echo "$a -ne $b : a is equal to b"
fi
 
if [ $a -gt $b ]
then
   echo "$a -gt $b: a is greater than b"
else
   echo "$a -gt $b: a is not greater than b"
fi
 
if [ $a -lt $b ]
then
   echo "$a -lt $b: a is less than b"
else
   echo "$a -lt $b: a is not less than b"
fi
 
if [ $a -ge $b ]
then
   echo "$a -ge $b: a is greater or  equal to b"
else
   echo "$a -ge $b: a is not greater or equal to b"
fi
 
if [ $a -le $b ]
then
   echo "$a -le $b: a is less or  equal to b"
else
   echo "$a -le $b: a is not less or equal to b"
fi
```
**RESULT:**
```
10 -eq 20: a is not equal to b
10 -ne 20: a is not equal to b
10 -gt 20: a is not greater than b
10 -lt 20: a is less than b
10 -ge 20: a is not greater or equal to b
10 -le 20: a is less or  equal to b
```
**NB:** It is very important to understand that all the conditional expressions should be inside square braces with spaces around them, for example `[ $a == $b ]` is correct whereas, `[$a==$b]` is incorrect.

## 3- Boolean Operators
