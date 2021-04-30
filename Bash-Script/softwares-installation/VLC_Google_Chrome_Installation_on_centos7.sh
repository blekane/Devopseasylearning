#! /usr/bin/bash

# VLC AND GOOGLE CHROME INSTALLATION  ON CENTOS 7

# root privilege if the user is not root, he will be prompt for password
if [ "$(whoami)" != "root" ]
then
    sudo -s "$0"
    exit
fi

# VLC packages
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm
yum -y install vlc

# google packages
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
yum -y install ./google-chrome-stable_current_*.rpm

# To remove google chrome setup
rm -rf "google-chrome-stable_current_x86_64.rpm"

echo "Installation of VLC and Google Chrome Copmpleted"
