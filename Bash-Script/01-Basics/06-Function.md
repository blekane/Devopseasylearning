# Function in Linux Shell Scripting 
A Bash function is essentially a set of commands that can be called numerous times. The purpose of a function is to help you make your bash scripts more readable and to avoid writing the same code over and over again.

function syntax in bash script. The first format starts with the function name, followed by parentheses. This is the preferred and more used format.

```sh
function_name () { 
   list of commands
}
```

The second format starts with the function reserved word followed by the function name.

```sh
function function_name () { 
   list of commands
}
```

**Example 1:**

```sh
#!/bin/bash
function hello_world () {
   echo 'hello world'
}
hello_world
```
OR

```sh
#!/bin/bash
function hello_world () {
   echo 'hello world'
}
hello_world
```

**Example 2:**
Calling one function from another function
```sh
#!/bin/sh
 
# Calling one function from another
number_one () {
   echo "This is the first function speaking..."
   number_two
}
number_two () {
   echo "This is now the second function speaking..."
}
# Calling function one.
number_one
```

Upon execution, you will receive the following result
```
This is the first function speaking...
This is now the second function speaking...
```


**Example 3:**
```sh 
#!/bin/bash

function COVID() {
# && = AND
# || = OR
read -p "Enter the first name: " FIRST_NAME 
read -p "Enter the last name: " LAST_NAME
read -p "Enter age: " AGE
read -p "Do you have fever (y or n)?: " FEVER
read -p "Do you have a cough? (y or n): " COUGH
read -p "Do you have any difficulty breathing? (y or n): " BREATHING
read -p "Have you been in contact with someone who has been tested positive with the Coronavirus? (y or n): " CONTACT
read -p "Did you travel outside the United States for the past 2 weeks? (y or n): " TRAVEL
read -p "Is anyone in your house cough, fever, difficulty breathing or have been in contact with someone who has been tested positive for Coronavirus? (y or n): "  HOUSE

if [ "$FEVER" = "n" ] && [ "$COUGH" = "n" ] && [ "$BREATHING" = "n" ] && [ "$CONTACT" = "n" ] && [ "$TRAVEL" = "n" ] && [ "$HOUSE" = "n" ]
then
    echo "Hello $FIRST_NAME $LAST_NAME, You do not need to be tested for COVID-19"

elif [ "$FEVER" = "y" ] || [ "$COUGH" = "y" ] || [ "$BREATHING" = "y" ] || [ "$CONTACT" = "y" ] || [ "$TRAVEL" = "y" ] || [ "$HOUSE" = "y" ]
then   
    echo "Hello $FIRST_NAME $LAST_NAME, You  need to be tested for COVID-19"
else
    echo "Please $FIRST_NAME $LAST_NAME, please check your answers"
fi
}
COVID
```

**Example 3:**
```sh
#!/bin/bash
echo "please answer those following questions by yes(Y) or not(N):"
test1 ()
{
    read -p "Do you have fever ? " yn
    case $yn in
        Y|y|Yes|YES|yes) 
        A=1
        ;;
        N|n|No|NO|no) 
        A=0
        ;;
        * ) echo "Please answer yes or no. Let's start again... "
            sh $0
        ;;
    esac
}
test1

test2 ()
{
    read -p "Do you have a cough ? " yn
    case $yn in
        Y|y|Yes|YES|yes) 
        B=1
        ;;
        N|n|No|NO|no) 
        B=0
        ;;
        * ) echo "Please answer yes or no. Let's start again... "
            sh $0
        ;;
    esac
}
test2

test3 ()
{
    read -p "Do you have any difficulty breathing ? " yn
    case $yn in
        Y|y|Yes|YES|yes) 
        C=1
        ;;
        N|n|No|NO|no) 
        C=0
        ;;
        * ) echo "Please answer yes or no. Let's start again... "
            sh $0
        ;;
    esac
}
test3

test4 ()
{
    local yn
    read -p "Have you been in contact with someone who has been tested positive with the Coronavirus ? " yn
    case $yn in
        Y|y|Yes|YES|yes) 
        D=1
        ;;
        N|n|No|NO|no) 
        D=0
        ;;
        * ) echo "Please answer yes or no. Let's start again... "
            sh $0
        ;;
    esac
}
test4

test5 ()
{
    read -p "Did you travel outside the United States for the past 2 weeks ? " yn
    case $yn in
        Y|y|Yes|YES|yes) 
        E=1
        ;;
        N|n|No|NO|no) 
        E=0
        ;;
        * ) echo "Please answer yes or no. Let's start again... "
            sh $0
        ;;
    esac
}
test5

test6 ()
{
    read -p "Is anyone in your house cough, fever, difficulty breathing or have been in contact with someone who has been tested positive for Coronavirus ? " yn
    case $yn in
        Y|y|Yes|YES|yes) 
        F=1
        ;;
        N|n|No|NO|no) 
        F=0
        ;;
        * ) echo "Please answer yes or no. Let's start again... "
            sh $0
        ;;
    esac
}
test6

if (( $((A+B+C+D+E+F))>=1 ))
then
  echo -e "\nYou might have the virus. \nPlease, call the 911 for more information and contact a specialist\n "
else
  echo -e "\nRegarding your answer, you do not need to be tested for COVID-19.\nPlease, be safe; follow instructions and save lives.\n"
fi
echo -e "You can use the link below for more information:\nhttps://www.cdc.gov/coronavirus/2019-ncov/cases-updates/summary.html\n"
```