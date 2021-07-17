# Decision Making in Linux Shell Scripting
[Build and push into 3 environments such as NONPROD, PROD AND QA](https://github.com/leonardtia1/MIX3/blob/master/Docker/09-Script-To-Build.md)

[Automated Daily Backups of Jenkins Master to Amazon S3 Bucket](https://github.com/leonardtia1/MIX3/tree/master/Jenkins/Jenkins-backup)

## Shell Decision Making
While writing a shell script, there may be a situation when you need to make use of conditional statements that allow your program to make correct decisions and perform the right actions.

Unix Shell supports conditional statements which are used to perform different actions based on different conditions. We will now understand two decision-making statements here. 
- The if, elif and else statement
- The case and esac statement

## 1- The if...else statements
If else statements are useful decision-making statements which can be used to select an option from a given set of options.
Unix Shell supports following forms of if…else statement 
- if...fi statement
- if...else...fi statement
- if...elif...else...fi statemen

**Syntax:**
```sh
if TEST-COMMAND1
then
  STATEMENTS1
elif TEST-COMMAND2
then
  STATEMENTS2
else
  STATEMENTS3
fi
```

**Example 1:**
```sh
#!/bin/bash
echo -n "Enter a number: "
read VAR
if [[ $VAR -gt 10 ]]
then
  echo "The variable is greater than 10."
fi
```

**Example 2:**
```sh 
#!/bin/bash
 
echo -n "Enter a number: "
read VAR
 
if [[ $VAR -gt 10 ]]
then
  echo "The variable is greater than 10."
else
  echo "The variable is equal or less than 10."
fi
```

**Example 3:**
```sh 
#!/bin/bash
 
echo -n "Enter a number: "
read VAR
 
if [[ $VAR -gt 10 ]]
then
  echo "The variable is greater than 10."
elif [[ $VAR -eq 10 ]]
then
  echo "The variable is equal to 10."
else
  echo "The variable is less than 10."
fi
```

**Example 3:**
- Nested if Statements
- Bash allows you to nest if statements within if statements. You can place multiple if statements inside another if statement.
```sh
#!/bin/bash
 
echo -n "Enter the first number: "
read VAR1
echo -n "Enter the second number: "
read VAR2
echo -n "Enter the third number: "
read VAR3
 
if [[ $VAR1 -ge $VAR2 ]]  
then
  if [[ $VAR1 -ge $VAR3 ]]
  then
    echo "$VAR1 is the largest number."
  else
    echo "$VAR3 is the largest number."
  fi
else
  if [[ $VAR2 -ge $VAR3 ]]
  then
    echo "$VAR2 is the largest number."
  else
    echo "$VAR3 is the largest number."
  fi
fi
```

**RESULT:**
```
Enter the first number: 4
Enter the second number: 7
Enter the third number: 2
7 is the largest number.
```

**Example 4:**
- Multiple Conditions
- The logical OR (||)  and AND (&&) operators allow you to use multiple conditions in the if statements.
```sh
#!/bin/bash
 
echo -n "Enter the first number: "
read VAR1
echo -n "Enter the second number: "
read VAR2
echo -n "Enter the third number: "
read VAR3

if [[ $VAR1 -ge $VAR2 ]] && [[ $VAR1 -ge $VAR3 ]]
then
  echo "$VAR1 is the largest number."
elif [[ $VAR2 -ge $VAR1 ]] && [[ $VAR2 -ge $VAR3 ]]
then
  echo "$VAR2 is the largest number."
else
  echo "$VAR3 is the largest number."
fi
```

 


