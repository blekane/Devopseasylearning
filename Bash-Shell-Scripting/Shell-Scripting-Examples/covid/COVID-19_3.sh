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
