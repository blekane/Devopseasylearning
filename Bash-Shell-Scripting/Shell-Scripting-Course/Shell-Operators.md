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

| Operator | Description | Example |
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

| Operator | Description | Example |
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
Logical `OR` & `AND` operations are very useful where multiple conditions are used in our programs (scripts). OR is used between two or multiple conditions. It returns true if any one of the conditions returns as true. AND is used between two or multiple conditions. **It returns true only if all the conditions return as true.**
- Logical OR in bash script is used with operator `-o` or `| |`
- Logical AND in bash script is used with operator `-a` or `&&`

The following Boolean operators are supported by the Bourne Shell.

Assume variable a holds 10 and variable b holds 20 
| Operator | Description | Example |
| :--- | :--- | :--- |
| ! | This is logical negation. This inverts a true condition into false and vice versa | [ ! false ] is true |
| -o | This is logical OR. If one of the operands is true, then the condition becomes true | [ $a -lt 20 -o $b -gt 100 ] is true |
| -a | This is logical AND. If both the operands are true, then the condition becomes true otherwise false | [  $a -lt 20 -a $b -gt 100 ] is false |

**Example 1:**
```sh 
#!/bin/sh
 
a=10
b=20
 
if [ $a != $b ]
then
   echo "$a != $b : a is not equal to b"
else
   echo "$a != $b: a is equal to b"
fi
 
if [ $a -lt 100 -a $b -gt 15 ] [ $a -lt 100 ] && [ $b -gt 15 ]
then
   echo "$a -lt 100 -a $b -gt 15 : returns true"
else
   echo "$a -lt 100 -a $b -gt 15 : returns false"
fi
 
if [ $a -lt 100 -o $b -gt 100 ]
then
   echo "$a -lt 100 -o $b -gt 100 : returns true"
else
   echo "$a -lt 100 -o $b -gt 100 : returns false"
fi
 
if [ $a -lt 5 -o $b -gt 100 ]
then
   echo "$a -lt 100 -o $b -gt 100 : returns true"
else
   echo "$a -lt 100 -o $b -gt 100 : returns false"
fi
```

**RESULT:**
```
10 != 20 : a is not equal to b
10 -lt 100 -a 20 -gt 15 : returns true
10 -lt 100 -o 20 -gt 100 : returns true
10 -lt 5 -o 20 -gt 100 : returns false
```

**Example 2:**
```sh
#!/bin/bash
read -p "Enter Your Number:"  i
 
if [ ( $i -ge 10  -a  $i -le 20 ) -o ( $i -ge 100  -a  $i -le 200 ) ]
then
        echo "OK"
else
    echo "Not OK"
fi
```

**Example 3:** with `||`
```sh
#!/bin/bash
read -p "Enter Your Number:"  i
 
if [ $i -ge 10  -o  $i -le 20 ] || [ $i -ge 100  -o  $i -le 200  ]
then
        echo "OK"
else
    echo "Not OK"
fi
```

**Example 4:** with `-a`
```sh
#!/bin/bash
read -p "Enter First Numeric Value: "   first
read -p "Enter Second Numeric Value: "  second
 
if [ $first -le 10  -a  $second -gt 20 ]
then
        echo "OK"
else
    echo "Not OK"
fi
```

**Example 4:** with `&&`
```sh
#!/bin/bash
read -p "Enter First Numeric Value: "   first
read -p "Enter Second Numeric Value: "  second
 
if [ $first -le 10 ] && [ $second -gt 20 ]
then
        echo "OK"
else
    echo "Not OK"
fi
```

## 4- String Operators
The following string operators are supported by Bourne Shell.
Assume variable a holds "abc" and variable b holds "efg" 

| Operator | Description | Example |
| :--- | :--- | :--- |
| != | Checks if the value of two operands are equal or not; if yes, then the condition becomes true | [ $a = $b ] is not true |
| -o | Checks if the value of two operands are equal or not; if values are not equal then the condition becomes true | [ $a != $b ] is true |
| -z | Checks if the given string operand size is zero; if it is zero length, then it returns true | [ -z $a ] is not true |
| -n | Checks if the given string operand size is non-zero; if it is nonzero length, then it returns true | [ -n $a ] is not false |
| str | Checks if str is not the empty string; if it is empty, then it returns false | [ $a ] is not false |

**Example:**
```sh
#!/bin/sh
 
a="abc"
b="efg"
 
if [ $a = $b ]
then
   echo "$a = $b : a is equal to b"
else
   echo "$a = $b: a is not equal to b"
fi
 
if [ $a != $b ]
then
   echo "$a != $b : a is not equal to b"
else
   echo "$a != $b: a is equal to b"
fi
 
if [ -z $a ]
then
   echo "-z $a : string length is zero"
else
   echo "-z $a : string length is not zero"
fi
 
if [ -n $a ]
then
   echo "-n $a : string length is not zero"
else
   echo "-n $a : string length is zero"
fi
 
if [ $a ]
then
   echo "$a : string is not empty"
else
   echo "$a : string is empty"
fi
```

**RESULT:**
```
abc = efg: a is not equal to b
abc != efg : a is not equal to b
-z abc : string length is not zero
-n abc : string length is not zero
abc : string is not empty
```

## 5- File Test Operators
We have a few operators that can be used to test various properties associated with a Unix file.

| Operator | Description | Example |
| :--- | :--- | :--- |
| -d file | Checks if the file is a directory; if yes, then the condition becomes true | [ -d $file ] is not true |
| -f file | Checks if file is an ordinary file as opposed to a directory or special file; if yes, then the condition becomes true | [ -f $file ] is true |
| -g file | Checks if the file has its set group ID (SGID) bit set; if yes, then the condition becomes true | [ -g $file ] is false |
| -k file | Checks if the file has its sticky bit set; if yes, then the condition becomes true | [ -k $file ] is false |
| -u file | Checks if the file has its Set User ID (SUID) bit set; if yes, then the condition becomes true | [ -u $file ] is false |
| -r file | Checks if the file is readable; if yes, then the condition becomes true | [ -r $file ] is true |
| -w file | Checks if the file is writable; if yes, then the condition becomes true | [ -w $file ] is true |
| -x file | Checks if the file is executable; if yes, then the condition becomes true | [ -r $file ] is true |
| -s file | Checks if the file has size greater than 0; if yes, then the condition becomes true | [ -s $file ] is true |
| -r file | Checks if the file is readable; if yes, then the condition becomes true | [ -r $file ] is true |
| -e file | Checks if file exists; is true even if file is a directory but exists | [ -e $file ] is true |

**Example:**
```sh
#!/bin/sh
cd /tmp/ && touch test.sh
file="/tmp/test.sh"
 
if [ -r $file ]
then
   echo "File has read access"
else
   echo "File does not have read access"
fi
 
if [ -w $file ]
then
   echo "File has write permission"
else
   echo "File does not have write permission"
fi
 
if [ -x $file ]
then
   echo "File has execute permission"
else
   echo "File does not have execute permission"
fi
 
if [ -f $file ]
then
   echo "File is an ordinary file"
else
   echo "This is special file"
fi
 
if [ -d $file ]
then
   echo "File is a directory"
else
   echo "This is not a directory"
fi
 
if [ -s $file ]
then
   echo "File size is not zero"
else
   echo "File size is zero"
fi
 
if [ -e $file ]
then
   echo "File exists"
else
   echo "File does not exist"
fi
```

**RESULT:**
```
File has read access
File has write permission
File does not have execute permission
File is an ordinary file
This is not a directory
File size is zero
File exists
```

