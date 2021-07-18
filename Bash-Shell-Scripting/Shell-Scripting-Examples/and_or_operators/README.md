### Example 1
```sh
#!/bin/bash
var="something"
if [ $var != "otherthing" ] && [ $var != "everything" ] && [ $var == "something" ]; then
    echo "this will be printed"
else
    echo "this will not be printed"
fi
```

### Example 2
```sh
#!/bin/bash
Option=y
if [ "$option" = "Y" ] || [ "$option" = "y" ]; then
    echo "Entered $option"
else
    echo "Entered wong option"
fi
```

### Example 3
```sh
#!/bin/bash
read -p "Enter First Numeric Value: "   first
read -p "Enter Second Numeric Value: "  second

if [ $first -le 10  -o  $second -gt 20 ]
then
        echo "OK"
else
	echo "Not OK"
fi
```


### Example 4
* Logical OR & AND operations are very useful where multiple conditions are used in our programs (scripts).
* OR is used between two or multiple conditions. It returns true if any one of conditions returns as true.
* AND is used between two or multiple conditions. It returns true only if all the conditions returns as true.
* Logical OR in bash script is used with operator -o or (||)
* Logical AND in bash script is used with operator -a or (&&)

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

### Example 5
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

### Example 6
```sh
#!/bin/bash
cat /etc/shadow > /dev/null && echo "Shadow file opened successfully" || echo "Shadow file Failed to open"

cat /etc/shadow > /dev/null && echo "Shadow file opened successfully" || echo "Shadow failed to open"

cat /etc/passwd > /dev/null && echo "passwd file opened successfully" || echo "passwd file failed to open"

cat /etc/group > /dev/null && echo "Group file opened successfully" || echo "Group failed to open"
```

### Example 6
* Logical OR & AND operations are very useful where multiple conditions are used in our programs (scripts).
* OR is used between two or multiple conditions. It returns true if any one of conditions returns as true.
* AND is used between two or multiple conditions. It returns true only if all the conditions returns as true.
* Logical OR in bash script is used with operator -o or (||)
* Logical AND in bash script is used with operator -a or (&&)
```sh
#!/bin/bash

a=10
b=20

if [ $a != $b ]
then
   echo "$a != $b : a is not equal to b"
else
   echo "$a != $b: a is equal to b"
fi

if [ $a -lt 100 -a $b -gt 15 ]
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