## Hand on:
Write a script that will run on Centos and Ubuntu servers.The script is going to do the following: 
- update the system 
- installed wget
- installed curl
- installed apache or httpd webserver
-  Download and host the following website: https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/static-website-example.zip 


Just a little happy new year script assignment for those who have requested. (It no mandatory though.)

Please write a script that will run on Centos (Red Hat) and Ubuntu servers. The script is going to do the following:
- Update the system
- Installed wget
- Installed curl
- Installed apache or HTTPD webserver
- Checked the memory, the root filesystem available
- Check if the user administrator exists. If yes, the script should not create the user. If not, the script should create a user.


## How to Compare Strings in Bash
[Compare Strings in Bash](https://linuxize.com/post/how-to-compare-strings-in-bash/)


## Checking Linux distribution with if statement
```sh
#!/bin/bash
UBUNTU=`cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}'`
CENTOS=`cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}' |awk -F" " '{print$2}' |awk -F'"' '{print$1}'`
AWS_CENTOS=`cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}' |awk -F" " '{print$3}' |awk -F'"' '{print$1}'`


if [[ $UBUNTU == "debian" ]]
then
    echo "This is Ubuntu server"
    exit 1

elif [[ $CENTOS == "fedora" ]] 
then
    echo "This is CentOs server"
    exit 2

elif [[ $AWS_CENTOS == "fedora" ]] 
then
    echo "This is AWS CentOs server"
    exit 2

else 
    echo ""
    echo "Unknow Linux distribution"
    exit 1
fi
```

## Installing packages and webserver with if statement base on Linux distribution
```sh
#!/bin/bash
UBUNTU=`cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}'`
CENTOS=`cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}' |awk -F" " '{print$2}' |awk -F'"' '{print$1}'`
AWS_CENTOS=`cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}' |awk -F" " '{print$3}' |awk -F'"' '{print$1}'`
IP=`hostname -I |awk '{print$1}'`
AWS_PUBLIC_DNS="ec2-18-218-82-126.us-east-2.compute.amazonaws.com"

if [[ $UBUNTU == "debian" ]]
then
    echo "This is Ubuntu server"
    sleep 3

    echo "Updating the system"
    sleep 3
    apt update -y

    echo "Installing wget command"
    sleep 3
    apt install wget -y

    echo "Installing curl command"
    sleep 3
    apt install curl -y

    echo "Installing httpd webserver"
    sleep 3
    apt install apache2 -y
    systemctl start apache2
    systemctl enable apache2

    echo "Opening port 80 on the firewall for httpd webserver"
    sleep 3
    ufw enable
    ufw allow 80/tcp
    ufw allow 'Apache'
    ufw reload

    echo "Hosting a static webside"
    sleep 3
    cd /var/www/html && rm -rf *
    wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/static-website-example.zip 
    unzip static-website-example.zip 
    cp -R static-website-example/* . 
    rm -rf static-website-example.zip 
    rm -rf static-website-example

    echo "Use the bellow URL to check your website on the browser:"
    sleep 2
    echo "http://$IP:80/"
    exit 2

elif [[ $CENTOS == "fedora" ]] 
then
    echo "This is CentOs server"
    sleep 3

    echo "Updating the system"
    sleep 3
    #yum update -y

    echo "Installing wget command"
    sleep 3
    yum install wget -y

    echo "Installing curl command"
    sleep 3
    yum install curl -y

    echo "Installing httpd webserver"
    sleep 3
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd

    echo "Opening port 80 on the firewall for httpd webserver"
    sleep 3
    firewall-cmd --zone=public --add-port=80/tcp --permanent
    firewall-cmd --reload

    echo "Hosting a static webside"
    sleep 3
    cd /var/www/html && rm -rf *
    wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/static-website-example.zip 
    unzip static-website-example.zip 
    cp -R static-website-example/* . 
    rm -rf static-website-example.zip 
    rm -rf static-website-example

    echo "Use the bellow URL to check your website on the browser:"
    sleep 2
    echo "http://$IP:80/"
    exit 2

elif [[ $AWS_CENTOS == "fedora" ]] 
then
    echo "This is AWS CentOs server"
    sleep 3

    echo "Updating the system"
    sleep 3
    #yum update -y

    echo "Installing wget command"
    sleep 3
    yum install wget -y

    echo "Installing curl command"
    sleep 3
    yum install curl -y

    echo "Installing httpd webserver"
    sleep 3
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd

    # echo "Opening port 80 on the firewall for httpd webserver"
    # sleep 3
    # firewall-cmd --zone=public --add-port=80/tcp --permanent
    # firewall-cmd --reload

    echo "Hosting a static webside"
    sleep 3
    cd /var/www/html && rm -rf *
    wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/static-website-example.zip 
    unzip static-website-example.zip 
    cp -R static-website-example/* . 
    rm -rf static-website-example.zip 
    rm -rf static-website-example

    echo "Use the bellow URL to check your website on the browser:"
    sleep 2
    echo "http://$AWS_PUBLIC_DNS:80/"
    exit 2

else 
    echo ""
    echo "Unknow Linux distribution"
    exit 1
fi
```

## Removing packages and webserver with if statement base on Linux distribution
```sh
#!/bin/bash
UBUNTU=`cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}'`
CENTOS=`cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}' |awk -F" " '{print$2}' |awk -F'"' '{print$1}'`
AWS_CENTOS=`cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}' |awk -F" " '{print$3}' |awk -F'"' '{print$1}'`


if [[ $UBUNTU == "debian" ]]
then
    echo "This is Ubuntu server"
    sleep 3
    echo "Removing httpd webserver"
    sleep 3
    apt remove apache2 -y

    echo "Removing wget"
    sleep 3
    apt remove wget -y

    echo "Removing curl"
    sleep 3
    apt remove curl -y

elif [[ $CENTOS == "fedora" ]] 
then
    echo "This is CentOs server"
    sleep 3

    echo "Removing httpd webserver"
    sleep 3
    yum remove httpd -y

    echo "Removing wget"
    sleep 3
    yum remove wget -y

    echo "Removing curl"
    sleep 3
    yum remove curl -y
    
    exit 1

elif [[ $AWS_CENTOS == "fedora" ]] 
then
    echo "This is AWS CentOs server"
    sleep 3

    echo "Removing httpd webserver"
    sleep 3
    yum remove httpd -y

    echo "Removing wget"
    sleep 3
    yum remove wget -y

    echo "Removing curl"
    sleep 3
    yum remove curl -y

    exit 1

else 
    echo ""
    echo "Unknow Linux distribution"
    exit 1
fi
```