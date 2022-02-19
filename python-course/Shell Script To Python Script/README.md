## Scripting

## Uname command
```py
#!/usr/bin/env python3
import subprocess
sp = subprocess.Popen(["uname", "-a"], shell=False, stdout=subprocess.PIPE,
                      stderr=subprocess.PIPE, universal_newlines=True)
rc = sp.wait()
out, err = sp.communicate()
print(out.split()[2].split(".")[0])

RESULT = out.split()[2].split(".")[0]
print(RESULT)

if RESULT == "5":
    print("The Kernel version is equal: {0}".format(RESULT))
else:
    print("The Kernel version is not eqaul: {0}".format(RESULT))
```

```py
#!/usr/bin/env python3
import subprocess
sp = subprocess.Popen(["uname -a"], shell=True, stdout=subprocess.PIPE,
                      stderr=subprocess.PIPE, universal_newlines=True)
rc = sp.wait()
out, err = sp.communicate()
print(out.split()[2].split(".")[0])

RESULT = out.split()[2].split(".")[0]
print(RESULT)

if RESULT == "5":
    print("The Kernel version is equal: {0}".format(RESULT))
else:
    print("The Kernel version is not eqaul: {0}".format(RESULT))
```


## COVID Script
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

```py
#!/usr/bin/env python3
def COVID():

    FIRST_NAME = input("Enter the first name: ")
    LAST_NAME = input("Enter the last name: ")
    AGE = input("Enter age: ")
    FEVER = input("Do you have fever (y or n)?: ")
    COUGH = input("Do you have a cough? (y or n): ")
    BREATHING = input("Do you have any difficulty breathing? (y or n): ")
    CONTACT = input(
        "Have you been in contact with someone who has been tested positive with the Coronavirus? (y or n): ")
    TRAVEL = input(
        "Did you travel outside the United States for the past 2 weeks? (y or n): ")
    HOUSE = input("Is anyone in your house cough, fever, difficulty breathing or have been in contact with someone who has been tested positive for Coronavirus? (y or n): ")

    if FEVER == "n" and COUGH == "n" and BREATHING == "n" and CONTACT == "n" and TRAVEL == "n" and HOUSE == "n":
        print("Hello {} {}, You  are {} years old, and you do not need to be tested for COVID-19".format(FIRST_NAME, LAST_NAME, AGE))

    elif FEVER == "y" or COUGH == "y" or BREATHING == "y" or CONTACT == "y" or TRAVEL == "y" or HOUSE == "y":
        print("Hello {} {}, You  are {} years old, and You need to be tested for COVID-19".format(FIRST_NAME, LAST_NAME, AGE))

    else:
        print("Hello {} {}, please check your answers".format(
            FIRST_NAME, LAST_NAME))


COVID()
```

## Some command
```sh
#!/bin/bash
if [ $UID -ne 0 ]
then
        echo -e "\nPlease, you need root access to run this script.....\n"
        exit 1
fi
echo -e "\nPlease make a choice below:   \n
        *********************************
        *       1==> nproc                *
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

echo -n "Enter your choice (1 - 10):   "
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
```

```py
#!/usr/bin/env python3
import os


def HELP():
    HELP = '''
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
        *********************************

    '''
    print(HELP)


HELP()


ANSWER = input("Enter your choice from the table between (1 - 10): ")

if ANSWER == "1":
    os.system("nproc")
    exit()

elif ANSWER == "2":
    os.system("free -h")
    exit()

elif ANSWER == "3":
    os.system("ps -ef")
    exit()

elif ANSWER == "4":
    os.system("ps -ef")
    exit()

elif ANSWER == "5":
    os.system("getconf LONG_BIT")
    exit()

elif ANSWER == "6":
    os.system("df -h")
    exit()

elif ANSWER == "7":
    os.system("ip a")
    exit()

elif ANSWER == "8":
    os.system("hostname")
    exit()

elif ANSWER == "9":
    os.system("uname -r")
    exit()

elif ANSWER == "10":
    os.system("apt update -y")
    exit()

else:
    HELP()
    ANSWER = input("Enter your choice from the table between (1 - 10): ")
```

```py
#!/usr/bin/env python3
import os


def HELP():
    HELP = '''
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
        *********************************

    '''
    print(HELP)


HELP()


ANSWER = input("Enter your choice from the table above between (1 - 10): ")


def switch(case):
    if case == "1":
        os.system("nproc")
        exit()

    elif case == "2":
        os.system("free -h")
        exit()

    elif case == "3":
        os.system("ps -ef")
        exit()

    elif case == "4":
        os.system("ps -ef")
        exit()

    elif case == "5":
        os.system("getconf LONG_BIT")
        exit()

    elif case == "6":
        os.system("df -h")
        exit()

    elif case == "7":
        os.system("ip a")
        exit()

    elif case == "8":
        os.system("hostname")
        exit()

    elif case == "9":
        os.system("uname -r")
        exit()

    elif case == "10":
        os.system("apt update -y")
        exit()

    else:
        print("Invalid Option")


switch(ANSWER)
```


## Install packages base on OS distro
```py
#!/usr/bin/env python3
import subprocess
import os

sp = subprocess.Popen(["cat /etc/*release"], shell=True, stdout=subprocess.PIPE,
                      stderr=subprocess.PIPE, universal_newlines=True)
rc = sp.wait()
out, e = sp.communicate()

PACKAGES = ["git", "tree", "curl", "unzip", "wget"]

for each_line in out.splitlines():
    if "ID_LIKE" in each_line and "debian" in each_line:
        OS = each_line.split("=")[1]

        if OS == "debian":
            print("This is {} server or Ubuntu".format(OS))
            for i in PACKAGES:
                subprocess.run(["apt-get", "install", "-y", i], check=True)
                
        elif OS == "fedora":
            print("This is {} server or Red Hat Enterprise Linux or CentOs ".format(OS))
            for i in PACKAGES:
                subprocess.run(["yum", "install", "-y", i], check=True)
        else:
            print("Hummmmm, I don't know this Linux distro")
```

```py
#!/usr/bin/env python3
import subprocess
import os

sp = subprocess.Popen(["cat /etc/*release"], shell=True, stdout=subprocess.PIPE,
                      stderr=subprocess.PIPE, universal_newlines=True)
rc = sp.wait()
out, e = sp.communicate()

for each_line in out.splitlines():
    if "ID_LIKE" in each_line and "debian" in each_line:
        OS = each_line.split("=")[1]
        
        if OS == "debian":
            print("This is {} server or Ubuntu".format(OS))
            os.system("apt-get install git -y")
            os.system("apt-get install tree -y")
            os.system("apt-get install curl -y")
            os.system("apt-get install unzip -y")
            os.system("apt-get install wget -y")
        elif OS == "fedora":
            print("This is {} server or Red Hat Enterprise Linux or CentOs ".format(OS))
            os.system("yum install git -y")
            os.system("yum install tree -y")
            os.system("yum install curl -y")
            os.system("yum install unzip -y")
            os.system("yum install wget -y")
        else:
            print("Hummmmm, I don't know this Linux distro")
```

## Jenkins installation
```sh
#! /bin/bash

# This script will install java and jenkins
 echo "Checking the operating system"
 OS=$(cat /etc/os-release |grep PRETTY_NAME | awk -F= '{print$2}' | awk -F '"' '{print$2}' |awk '{print$1}')

echo 'checking if jenkins is installed'
ls /var/lib |grep jenkins
if 
[[ ${?} -eq 0 ]]
then 
    echo "Jenkins is install"
    exit 1
    else

case $OS in
Ubuntu)
     sudo apt update
     sudo apt install ca-certificates -y
sudo apt search openjdk
sudo apt install openjdk-11-jdk -y
java -version
ufw allow 8080/tcp   2& > /dev/null 
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
sudo apt-get install jenkins -y
systemctl start jenkins 
systemctl enable jenkins

;;

CentOS) 
  
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo yum install jenkins java-11-openjdk-devel -y
sudo systemctl daemon-reload
systemctl start jenkins 
systemctl enable jenkins
firewall-cmd --permanent --add-port=8080/tcp   2& > /dev/null 
firewall-cmd --reload 2& > /dev/null

;;


Amazon)
  
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo yum install jenkins java-1.8.0 -y
sudo systemctl daemon-reload
systemctl start jenkins 
systemctl enable jenkins
firewall-cmd --permanent --add-port=8080/tcp   2& > /dev/null   
firewall-cmd --reload 2& > /dev/null

;;

*)
   echo "your operating system is UNKNOWN"
   exit 1
   ;;
esac 

fi
```

```py
#!/usr/bin/env python3
import subprocess
import os

'''
Author: Tia Leo
Date: Dec 24, 2022
This script is used ti install Jenkins, and it can only runs of Debain and Fedora base OS
'''

sp = subprocess.Popen(["cat /etc/*release"], shell=True, stdout=subprocess.PIPE,
                      stderr=subprocess.PIPE, universal_newlines=True)
rc = sp.wait()
out, e = sp.communicate()

for each_line in out.splitlines():
    if "ID_LIKE" in each_line and "debian" in each_line:
        OS = each_line.split("=")[1]

        if OS == "debian":
            print("This is {} server or Ubuntu".format(OS))
            os.system("sudo apt update")
            os.system("sudo apt install ca-certificates -y")
            os.system("sudo apt search openjdk")
            os.system("sudo apt install openjdk-11-jdk -y")
            os.system("ufw allow 8080/tcp   2& > /dev/null")
            os.system(
                "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -")
            os.system("sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
                        /etc/apt/sources.list.d/jenkins.list'")
            os.system("sudo apt-get update -y")
            os.system("sudo apt-get install jenkins -y")
            os.system("systemctl start jenkins")
            os.system("systemctl enable jenkins")

        elif OS == "fedora":
            print("This is {} server or Red Hat Enterprise Linux or CentOs ".format(OS))
            os.system("sudo wget -O /etc/yum.repos.d/jenkins.repo \
                        https://pkg.jenkins.io/redhat-stable/jenkins.repo")
            os.system(
                "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key")
            os.system("sudo yum upgrade -y")
            os.system("sudo yum install jenkins java-11-openjdk-devel -y")
            os.system("sudo systemctl daemon-reload")
            os.system("systemctl start jenkins")
            os.system("systemctl enable jenkins")
            os.system(
                "firewall-cmd --permanent --add-port=8080/tcp   2& > /dev/null")
            os.system("firewall-cmd --reload 2& > /dev/null")
        else:
            print("Hummmmm, UNKNOWN Linux distro")
```

## Useradd

```sh
#!/bin/bash

cat << EOF > /tmp/users.txt
kareen
jires
biky
abdou
EOF

username=$(cat /tmp/users.txt | tr '[A-Z]' '[a-z]')

function user_add() {
    for users in $username
    do
        ls /home |grep $users &>/dev/nul || mkdir -p /home/$users 
        cat /etc/passwd |awk -F: '{print$1}' |grep -w $users &>/dev/nul ||  useradd $users
        chown -R $users:$users /home/$users
        usermod -s /bin/bash -aG docker $users
        echo -e "$users\n$users" |passwd "$users"
        # passwd --expire $users
    done
}
```

```py
#!/usr/bin/env python3

import subprocess
import time
import subprocess
import crypt
import os

USERS = '''
kareen
TIA
biky
abdou
paul
'''.lower().split()


def add_user():
    for e in USERS:
        encPass = crypt.crypt(e)
        print(encPass)


add_user()

print(USERS)
try:
    for i in USERS:
        sp = subprocess.Popen(["id", i],
                              shell=False,
                              stdout=subprocess.PIPE,
                              stderr=subprocess.PIPE,
                              universal_newlines=True)
        rc = sp.wait()
        out, err = sp.communicate()

        if rc == 0:
            time.sleep(1)
            print("User {0} is already exist on this server".format(i))
except:
    print(err)

else:
    time.sleep(1)
    print("Adding user {0} ---------Please wait ----------".format(i))
    # subprocess.run(["useradd", i], check=True)
    for e in USERS:
        subprocess.run(['useradd', '-p', crypt.crypt(e), e])


sp1 = subprocess.Popen(["cat /etc/group"],
                       shell=True,
                       stdout=subprocess.PIPE,
                       stderr=subprocess.PIPE,
                       universal_newlines=True)
rc = sp1.wait()
out, e = sp1.communicate()
try:
    for each_line in out.splitlines():
        if "admin" in each_line and "x" in each_line:
            GROUP = each_line.split(":")[0]
            if GROUP == "admin":
                print("The group {} exist already on this server".format(GROUP))
                for i in USERS:
                    sp = subprocess.Popen(["id", i],
                                          shell=False,
                                          stdout=subprocess.PIPE,
                                          stderr=subprocess.PIPE,
                                          universal_newlines=True)
                    subprocess.run(["usermod", "-aG", "admin", i], check=True)
                    os.chdir("/home")
                    subprocess.run(["mkdir", "-p", i], check=True)
except:
    print(e)
else:
    os.system("groupadd admin")
    for i in USERS:
        sp = subprocess.Popen(["id", i],
                              shell=False,
                              stdout=subprocess.PIPE,
                              stderr=subprocess.PIPE,
                              universal_newlines=True)
        subprocess.run(["usermod", "-aG", "admin", i], check=True)


sp3 = subprocess.Popen(["cat /etc/sudoers"],
                       shell=True,
                       stdout=subprocess.PIPE,
                       stderr=subprocess.PIPE,
                       universal_newlines=True)
rc = sp3.wait()
out, e = sp3.communicate()

try:
    for each_line in out.splitlines():
        if "admin" in each_line and "ALL" in each_line:
            ADMIN = each_line.split()[0].strip("%")
            if ADMIN == "admin":
                print("The group {} exist already in the sudoers file".format(ADMIN))
except:
    print(e)
else:
    os.system("echo '%admin ALL=(ALL) ALL' >> /etc/sudoers")
```


## Building docker images
```sh
ENVIRONMENT_PROD=prod
ENVIRONMENT_NONPROD=nonprod

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

```PY
#!/usr/bin/env python3
import sys

ENVIRONMENT_PROD = "prod"
ENVIRONMENT_NONPROD = "nonprod"

PARAM_ENV = sys.argv[1]
PARAM_TAG = sys.argv[3]
VALUE = sys.argv[2]
TAG = sys.argv[4]


def USAGE():
    print()
    print("ERROR: Check the below usage to build the image according to your environement: ")
    print("Usage for Jenkins nonprod image: {} --env {} --tag <image tag name>".format(sys.argv[0], ENVIRONMENT_NONPROD))
    print( "Usage for Jenkins prod image: {} --env {} --tag <image tag name>".format(sys.argv[0], ENVIRONMENT_PROD))
    print("Example: {} --env {} --tag jenkins-nonprod".format(sys.argv[0], ENVIRONMENT_PROD))
    print()


if VALUE == ENVIRONMENT_NONPROD and PARAM_ENV == "--env"  and PARAM_TAG == "--tag": 
    print("Building Jenkins {} image and pushing it into AWS ECR".format(VALUE))
    sys.exit()

elif VALUE == ENVIRONMENT_PROD and PARAM_ENV == "--env"  and PARAM_TAG == "--tag": 
    print("Building Jenkins {} image and pushing it into AWS ECR".format(VALUE))
    sys.exit()
else:
    USAGE()
    sys.exit()


# OUTPUT 1
$ python3 python.py --env prod --tagssssss jenkins-nonprod

ERROR: Check the below usage to build the image according to your environement: 
Usage for Jenkins nonprod image: python.py --env nonprod --tag <image tag name>
Usage for Jenkins prod image: python.py --env prod --tag <image tag name>
Example: python.py --env prod --tag jenkins-nonprod

# OUTPUT 2
$ python3 python.py --env prod --tag jenkins-nonprod
Building Jenkins prod image and pushing it into AWS ECR
```






























