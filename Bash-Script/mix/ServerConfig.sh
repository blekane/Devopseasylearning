#!/bin/bash





#Description: Script to configure the Server's Hostname , Dns, Default run level 




usage() 
{
   echo -e "\n\nPlease enter a number ( 1, 2 or 3) to indicate your choice"
   echo " 1 ==> Hostname "
   echo " 2 ==> Dns "
   echo " 3 ==> Default runlevel"
   echo
   exit 1
}


ch()
{
   echo -e "\nPlease choose one of the options"
   echo " 1==> Hostname "
   echo " 2==> Dns "
   echo " 3==> Default runlevel"
 
read CHOICE
}

ch

 
while [[ ${CHOICE} -ne 1 ]]  2>/dev/null || [[ ${CHOICE} -ne 2 ]] 2>/dev/null || [[ ${CHOICE} -ne 3 ]] 2>/dev/null || [ -z ${CHOICE} ]  2>/dev/null;
do
if  
  [ ${CHOICE} -eq 1 ] 2>/dev/null
then
echo "You choose 1"
exit 0
elif
  [[ ${CHOICE} -eq 2 ]] 2>/dev/null
then
echo "you choose 2 "
exit 0
elif
  [[ ${CHOICE} -eq 3 ]] 2>/dev/null
then
echo " you have choosen 3"
exit 0
else
ch
fi
done
