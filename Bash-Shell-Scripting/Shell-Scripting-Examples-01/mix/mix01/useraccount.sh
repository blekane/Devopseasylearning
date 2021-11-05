#!/bin/bash
#########################################################################
new_generic_account () {
  useradd $account_name
  passwd $account_name
  return
}
########################################################################
########################################################################
new_custom_account () {
read -p "what section of the account do you wish to customize? type uid, gid, dir, or shell: " custom
echo
if [[ $custom == "uid" ]] ; then
read -p "Please enter the customized user id: " c_uid
echo
usermod -u $c_uid $account_name
elif [[ $custom == "gid" ]] ; then
read -p "Do you want to add the user to a New or Existing group? (type n/e): " group_type
echo
####### this block will check whether or not the group that the user is trying to create already exist
if [[ $group_type == "n" ]]; then
read -p "Please enter the group name: " group_name
echo ""
read -p "Please enter the customized group id: " g_uid
echo
groupadd -g $g_uid $group_name
usermod -g $g_uid $account_name
elif [[ $group_type == "e" ]]; then
read -p "Please enter the corresponding group id: " g_uid
usermod -g $g_uid $account_name
echo
else echo "Sorry! You entered the wrong selection"
fi
#########
echo
elif [[ $custom == "dir" ]] ; then
read -p "Please enter the customized dir: " d_uid
usermod -d $d_uid $account_name
echo
elif [[ $custom == "shel" ]] ; then
read -p "Please enter the customized group id: " shel_uid
usermod -s $shel_uid $account_name
echo
else echo "you didn't pick any of the offered options. Please repeat"
fi
##########
##########
echo
read -p "Do you wish to modify anything else? (please type y/n): " custom2
if [[ $custom2 == "y" ]]; then
new_custom_account1
elif [[ $custom2 == "n" ]]; then
echo
echo "Thank you for using the account mangement script"
echo
else echo "you enter the wrong selection. Please restart."
fi

############
############
return
new_custom_account1
}
###############################################################################
###############################################################################
new_custom_account1 () {
read -p "what section of the account do you wish to customize? type uid, gid, dir, or shell: " custom
if [[ $custom == "uid" ]] ; then
echo
read -p "Please enter the customized user id: " c_uid
usermod -u $c_uid $account_name
echo
elif [[ $custom == "gid" ]] ; then
read -p "Do you want to add the user to a New or Existing group? (type n/e): " group_type
echo
####### this block will check whether or not the group that the user is trying to create already exist
if [[ $group_type == "n" ]]; then
read -p "Please enter the group name: " group_name
echo ""
read -p "Please enter the customized group id: " g_uid
groupadd -g $g_uid $group_name
usermod -g $g_uid $account_name
elif [[ $group_type == "e" ]]; then
echo
read -p "Please enter the corresponding group id: " g_uid
usermod -g $g_uid $account_name
echo
else echo "Sorry! You entered the wrong selection"
fi
#########

elif [[ $custom == "dir" ]] ; then
echo
read -p "Please enter the customized dir: " d_uid
usermod -d $d_uid $account_name
echo
elif [[ $custom == "shel" ]] ; then
read -p "Please enter the customized group id: " shel_uid
usermod -s $shel_uid $account_name
echo
else echo "you didn't pick any of the offered options. Please repeat"
fi
##########
##########
echo
read -p "Do you wish to modify anything else? (please type y/n): " custom2
if [[ $custom2 == "y" ]]; then
new_custom_account1
elif [[ $custom2 == "n" ]]; then
echo
echo "Thank you for using the account mangement script"
echo
else echo "you enter the wrong selection. Please restart."
fi
############
############
return
new_custom_account
}
###############################################################################
###############################################################################
echo
echo "Greetings! Welcome to the user's acccount managment script. This script
allows you to create account (s) from scratch or modify exiting one (s)"
sleep 4
echo ""
read -p "Please enter the account name you wish to manage: " account_name
echo ""
sleep 2
read -p "Is this a brand new account or an existing one?
(type new or existing): " choice
echo ""
sleep 2
if [[ $choice == "new" ]]; then
read -p "Do you want to create a generic or custom account?
(type g for generic and c for custom): " account_type
echo ""

#######
      if [[ $account_type == "g" ]]; then
      new_generic_account
      echo
      echo "Congratulation! You have successfully created the following account: "
      cat /etc/passwd | grep --color $account_name

      elif [[ $account_type == "c" ]]; then
      useradd $account_name
      new_custom_account
      echo
      echo "Congratulation! You have successfully created the following account: "
      cat /etc/passwd | grep --color $account_name
      ##
      else echo "the value entered wasnt part of the list. please restart."
      fi
#######
elif [[ $choice == "existing" ]]; then
new_custom_account
sleep 2
echo "Congratulation! You have successfully created the following account: "
echo
sleep 4
cat /etc/passwd | grep --color $account_name
echo ""
else echo "your selection was not part of the options. Please restart"
fi
echo
