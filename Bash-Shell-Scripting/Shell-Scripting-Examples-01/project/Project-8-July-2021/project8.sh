## How to Compare Strings in Bash
## https://linuxize.com/post/how-to-compare-strings-in-bash/

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




#!/bin/bash
#Authhor: CHRISTIAN KAM
#Purpose: Basic administration task/project 8
#Date: 07/28/2021
#Modification: 08/02/2021

Hosting()
{
    echo "Hosting The website"
    sudo wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/static-website-example.zip
    sudo unzip static-website-example.zip 
    cp -r /static-website-example/. /var/www/html/
    echo " please use the address bellow to access to the webside"
    echo "http://$IP/"   
}

centos() 
{
    echo "Updating the system"
    sudo yum update -y 
    if  test $? -eq 0
     then 
     echo "Update completed" 
     sleep 3
     else
     echo "Update failed"
     sleep 3
    fi
    echo "installing  wget"
     sudo yum install wget -y
    if test $? -eq 0
     then
     echo "wget installed " 
     else
     echo " wget installation failed"
    fi
    echo "installing curl" 
     sudo yum install curl -y 
      if test $? -eq 0
     then
     echo "curl installed " 
     else
     echo "curl installation failed"
    fi
    
    echo "installing apache or httpd webserver"
     sudo yum install httpd -y
     systemctl start httpd
     systemctl enable httpd
     firewall-cmd --zone=public --add-port=80/tcp --permanent
     firewall-cmd --reload
    if test $? -eq 0
     then
     echo "appache installed " 
     else
     echo "appache installation failed"
    fi

    Hosting 
}


ubuntu()
{
   echo "Updating the system"
    sudo apt-get update -y
    if  test $? -eq 0
     then 
     echo "Update completed" 
     sleep 3
     else
     echo "Update failed"
     sleep 3
    fi
    echo "installing  wget"
     sudo apt-get install wget  -y
    if test $? -eq 0
     then
     echo "wget installed " 
     else
     echo " wget installation failed"
    fi
    echo "installing curl" 
     sudo apt-get install curl -y 
      if test $? -eq 0
     then
     echo "curl installed " 
     else
     echo "curl installation failed"
    fi
    
    echo "installing apache or httpd webserver"
     sudo apt-get install apache2  -y
     systemctl start httpd
     systemctl enable httpd
     sudo ufw allow 80/tcp
     sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
     sudo apt-get install iptables-persistent -y
     sudo ufw reload
    if test $? -eq 0
     then
     echo "appache installed " 
     else
     echo "appache installation failed"
    fi

    Hosting 
}

IP=$(ip route get 1.2.3.4 | awk '{print $7}')
OS=$(cat /etc/*release |grep ID |head -1 |awk -F= '{print$2}' |awk -F'"' '{print$2}')
if [ "$OS" = "centos" ]
 then 
 centos
 elif [ "$OS" = "Ubuntu" ] 
 then 
 ubuntu 
 else
 echo "UNKNOWN OS"
 exit
fi 