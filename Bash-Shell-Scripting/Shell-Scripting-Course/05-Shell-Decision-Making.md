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

**Example 5:**
```sh
echo -e "\nPlease make a choice below:   \n
        *********************************
        *       1==> cpu                *
        *       2==> Memory             *
        *       3==> Os version         *
        *       4==> processes          *
        *       5==> system bits        *
        *       6==> mount points       *
        *       7==> ip address         *
        *       8==> Hostname           *
        *       9==> Kernel version     *
        *       10==> update OS         *
        *********************************\n"

echo -n " Enter your choice (1 - 10):   "
read ans


if  [ ${ans} -eq 1 ] 
then
lscpu

elif  [ ${ans} -eq 2 ]
then
free -h

elif [ ${ans} -eq 3 ]
then
cat /etc/*release

elif [ ${ans} -eq 4 ] 
then
ps -ef

elif [ ${ans} -eq 5 ]
then
getconf LONG_BIT

elif [ ${ans} -eq 6 ]
then
df -h

elif  [ ${ans} -eq 7 ] 
then
ip a

elif  [ ${ans} -eq 8 ]
then
hostname

elif  [ ${ans} -eq 9 ] 
then
uname -r

elif  [ ${ans} -eq 10 ] 
then
yum update -y

else
echo -e "\nPlease enter a valid choice (1- 10) \n"
exit 2
fi


**Example 6:**
```sh
#!/bin/bash

read -p "Enter the first name: " FIRST_NAME 
read -p "Enter the last name: " LAST_NAME
read -p "Enter age: " AGE
read -p "Do you have fever (y or n)?: " FEVER
read -p "Do you have a cough? (y or n): " COUGH
read -p "Do you have any difficulty breathing? (y or n): " BREATHING
read -p "Have you been in contact with someone who has been tested positive with the Coronavirus? (y or n): " CONTACT
read -p "Did you travel outside the United States for the past 2 weeks? (y or n): " TRAVEL
read -p "Is anyone in your house cough, fever, difficulty breathing or have been in contact with someone who has been tested positive for Coronavirus? (y or n): "  HOUSE

if [ "$FEVER" = "y" -o  "$COUGH" = "y" -o "$BREATHING" = "y" -o "$CONTACT" = "y" -o "$TRAVEL" = "y" -o "$HOUSE" = "y" ]
then
    echo "Hello $FIRST_NAME $LAST_NAME, You need to be tested for COVID-19"
elif [ "$FEVER" = "n" -a  "$COUGH" = "n" -a "$BREATHING" = "n" -a "$CONTACT" = "n" -a "$TRAVEL" = "n" -a "$HOUSE" = "n" ]
then
    echo "Hello $FIRST_NAME $LAST_NAME, You do not need to be tested for COVID-19"
else
    echo "Please $FIRST_NAME $LAST_NAME, please check your answers"
    exit
fi
```

**Example 7:**
```sh
ENVIRONMENT_PROD=prod
ENVIRONMENT_NONPROD=nonprod

DOCKER_REGISTRY_PROD=xxxxxxxx.dkr.ecr.us-east-1.amazonaws.com
DOCKER_REGISTRY_NONPROD=xxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com
DOCKER_REPO=jenkins

PARAM_ENV=`echo $1 | awk -F= '{print $1}'`
PARAM_TAG=`echo $3 | awk -F= '{print $1}'`
VALUE=`echo $2 | awk -F= '{print $1}'`
TAG=`echo $4 | awk -F= '{print $1}'`


if [ $VALUE == $ENVIRONMENT_NONPROD ] && [ $PARAM_ENV == "--env" ] && [ $PARAM_TAG == "--tag" ]
then
    echo "Building Jenkins $VALUE image and pushing it into AWS ECR"
    exit 1

elif [ $VALUE == $ENVIRONMENT_PROD ] && [ $PARAM_ENV == "--env" ] && [ $PARAM_TAG == "--tag" ]
then
    echo "Building Jenkins $VALUE image and pushing it into AWS ECR"
    exit 2

else 
    echo ""
    echo "ERROR: Check the below usage to build the image according to your environement: "
    echo "Usage for Jenkins nonprod image: $0 --env $ENVIRONMENT_NONPROD --tag <image tag name>"
    echo "Usage for Jenkins prod image: $0 --env $ENVIRONMENT_PROD --tag <image tag name>"
    echo "Example: $0 --env $ENVIRONMENT_NONPROD --tag jenkins-nonprod"
    echo ""
    exit 1
fi
```
python3 python.py --env prod --tag jenkins-nonprod
```sh
else 
    echo ""
    echo  $'\e[1;33m'ERROR: Check the below usage to build the image according to your environement$'\e[0m'
    echo  $'\e[1;33m'Usage for Jenkins nonprod image: $0 --env $ENVIRONMENT_NONPROD --tag [image tag name]$'\e[0m'
    echo  $'\e[1;33m'Usage for Jenkins prod image: $0 --env $ENVIRONMENT_PROD --tag [image tag name]$'\e[0m'
    echo  $'\e[1;33m'Example: $0 --env $ENVIRONMENT_NONPROD --tag jenkins-nonprod$'\e[0m'
    echo ""
    exit 1
fi
```

## 2- Case statement
Syntax of bash case statement.

```sh
case EXPRESSION in
 
  PATTERN_1)
    STATEMENTS
    ;;
 
  PATTERN_2)
    STATEMENTS
    ;;
 
  PATTERN_N)
    STATEMENTS
    ;;
 
  *)
    STATEMENTS
    ;;
esac
```

**Example 1:**
```sh
#!/bin/bash
 
echo "Enter the name of a country: "
read COUNTRY
 
echo "The official language of $COUNTRY is "
 
case $COUNTRY in
 
  Lithuania)
    echo "Lithuanian"
    ;;
 
  Romania | Moldova)
    echo "Romanian"
    ;;

  USA | US | us | usa | "United States" | "united states")
    echo "English"
    ;;

  Cameroon | cameroon)
    echo "English and Fresh"
    ;;
 
  Italy | "San Marino" | Switzerland | "Vatican City")
    echo "Italian"
    ;;
 
  *)
    echo "unknown"
    ;;
esac
```

**Example 2:**
```sh
#!/bin/bash
 
printf 'Which Linux distribution do you know? '
read DISTR
 
case $DISTR in
     ubuntu | Ubuntu | ubuntu20 | "ubuntu 20" | "Ubuntu 20")
          echo "I know it! It is an operating system based on Debian."
          ;;
     centos|Centos|rhel|RHEL)
          echo "Hey! It is my favorite Server OS!"
          ;;
     windows)
          echo "Hummm, Very funny..."
          ;; 
     mac | MAC | "MAC OS" | "Mac OS")
          echo "MAC OS has a CLI like Linu/Unix OS"
          ;;
     *)
          echo "Hmm, seems i've never used it."
          ;;
esac
```

**Example 3:**
```sh
cat << EOF
    ****************************
    * 1 = service sshd status  *
    * 2 = service sshd start   *
    * 3 = service sshd restart *
    * 4 = service sshd stop    *
    ****************************
EOF
echo "Enter your choice here:  "
 
read ans 
case ${ans} in 
    1) service sshd status 
    ;;
    2) service sshd start
    ;;
    3) service sshd restart
    ;;
    4) service sshd stop
    ;;
    *) echo "invalid choice, please choose between 1, 2, 3 and 4"
 
esac
```

**Example 4:**
```sh
#!/bin/bash
 
read -p "Enter your choice [yes/no]:" choice
 
case $choice in
     Y|y|Yes|YES|yes)
          echo "Thank you"
          echo "Your type: Yes"
          ;;
     N|n|No|NO|no)
          echo "Oops"
          echo "You type: No"
          ;;
     *)
          echo "Sorry, invalid input"
          ;;
esac
```

**Example 5:**
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


**Example 6:**
```sh
#!/bin/bash
echo "please answer those following questions by yes(Y) or not(N):"
test1 ()
{
    local yn
    read -p "Do you have fever ? " yn
    case $yn in
        [Yy]* ) A=1;;
        [Nn]* ) A=0;;
        * ) echo "Please answer yes or no. Let's start again... "
            bash $0;;
    esac
}
test1
test2 ()
{
    local yn
    read -p "Do you have a cough ? " yn
    case $yn in
        [Yy]* ) B=1;;
        [Nn]* ) B=0;;
        * ) echo "Please answer yes or no. Let's start again... "
            bash $0;;
    esac
}
test2
test3 ()
{
    local yn
    read -p "Do you have any difficulty breathing ? " yn
    case $yn in
        [Yy]* ) C=1;;
        [Nn]* ) C=0;;
        * ) echo "Please answer yes or no. Let's start again... "
            bash $0;;
    esac
}
test3
test4 ()
{
    local yn
    read -p "Have you been in contact with someone who has been tested positive with the Coronavirus ? " yn
    case $yn in
        [Yy]* ) D=1;;
        [Nn]* ) D=0;;
        * ) echo "Please answer yes or no. Let's start again... "
            bash $0;;
    esac
}
test4
test5 ()
{
    local yn
    read -p "Did you travel outside the United States for the past 2 weeks ? " yn
    case $yn in
        [Yy]* ) E=1;;
        [Nn]* ) E=0;;
        * ) echo "Please answer yes or no. Let's start again... "
            bash $0;;
    esac
}
test5
test6 ()
{
    local yn
    read -p "Is anyone in your house cough, fever, difficulty breathing or have been in contact with someone who has been tested positive for Coronavirus ? " yn
    case $yn in
        [Yy]* ) F=1;;
        [Nn]* ) F=0;;
        * ) echo "Please answer yes or no. Let's start again... "
            bash $0;;
    esac
}
test6
if (( $((A+B+C+D+E+F))>=1 ))
then
  echo "you might have the virus please, call the 911 for more information and contact a specialist "
else
  echo -e "\n regarding your answer, you haven't contracted the virus\nPlease, be safe; \t follow instructions and save lives."
fi
echo -e "you can use the link below for more information:\nhttps://www.cdc.gov/coronavirus/2019-ncov/cases-updates/summary.html"
```