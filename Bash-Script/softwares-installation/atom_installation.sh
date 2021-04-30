#! /usr/bin/bash

# How to install Atom Text Editor on CentOS 7

# root privilege if the user is not root
echo "Please enter you password if your are not a root user."

if [ "$(whoami)" != "root" ]
then
    sudo -s "$0"
    exit
fi

echo "installing git."
yum install wget git -y
echo "Downloading atom packages from https://atom.io/"
wget https://github.com/atom/atom/releases/download/v1.18.0/atom.x86_64.rpm # to download atom
echo "Installing atom package"
yum localinstall atom.x86_64.rpm -y # to install atom

# atom will setup will be safe in the same directory with the script
rm -rf "atom.x86_64.rpm" # to remove atom from home directory

echo "Type Atom in your terminal to launch the Text Editor or go to application- programming and launch atom"
echo "Enjoy Atom!"
