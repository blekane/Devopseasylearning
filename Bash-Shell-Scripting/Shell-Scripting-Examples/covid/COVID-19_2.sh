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





