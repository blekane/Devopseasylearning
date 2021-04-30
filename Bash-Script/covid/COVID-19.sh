#!/bin/bash

function COVID-19() {
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
    echo "Please $FIRST_NAME $LAST_NAME, Check you are answers"
    exit
fi
}


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
    echo "Please $FIRST_NAME $LAST_NAME, Check you are answers"
    COVID-19
fi


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
    echo "Please $FIRST_NAME $LAST_NAME, Check you are answers"
fi
}



