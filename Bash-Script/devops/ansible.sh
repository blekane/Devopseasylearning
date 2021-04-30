#!/bin/bash

# This script will install ansible on centos

# Author: Tia M
# Date: October 21, 2019
# Modified on:             by:

# tyo install ansible repository because it isn't install by default
yum install epel-release -y

# to install ansible
yum install ansible

# to check the version
ansible --version

