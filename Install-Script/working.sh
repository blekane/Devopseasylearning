#!/bin/bash

DIR="${HOME}/generator"
USER_SCRIPT=$USER
LOCALHOST_IP=$(ip route get 1.2.3.4 | awk '{print $7}')
# Below variable will print your public IP if your Virtual machine is not in the cloud (http://99.190.62.232:8080 )
CLOUD_PUBLIC_IP=`curl -s ifconfig.me` 
OS=`cat /etc/os-release |grep PRETTY_NAME | awk -F= '{print$2}' | awk -F '"' '{print$2}' |awk '{print$1}'`

# Help Function
help_list() {
  echo
  echo "Help is on the way................Please wait.................."
  sleep 5

  echo -e "
  \033[1;36m
  Usage of ${0}:
  \033[1;36m

\033[1;31m
  bash ${0##*/} [-h] -----> For help
  bash ${0##*/} [-a] -----> For api
  bash ${0##*/} [-j] -----> For Jenkins
  And so no
\033[1;36m

\033[1;36m
Options:

  -h, --help
    can I help you ?

  -j, --jenkins
    run jenkins on VM

  -jc, --jenkins-c
    run jenkins container

  -p, --packages
    run install packages

   -s, --sonarqube
    run sonarqube container

  -n, --nexus
    run sonarqube container

  -post, --postgres
    run postgres and pgadmin container
  
   -rm, --docker-rm
    Stop and delete all containers

  -rmi, --docker-rmi
     Delete all images

  -all, --del
     Stop ,delete all containers and all images
\033[0m

\033[1;32m
-port, 
  This is the list of ports that need to be open on the security group:
    - 80      :For HTTP
    - 8080    :For Jenkins on Host
    - 5555    :For Pgdamin
    - 9000    :For Sonarqube  
    - 443     :For HTTPS
    - 22      :For SSH
    - 8070    :For Jenkins in the Container
    - 8081    :For Nexus
    - 5432    :For Postgres
\033[0m     
  "
}


# Main Function
options() {
  case $@ in
    -h|--help)
      help_list
      exit
     ;;
     -j|--jenkins)
      jenkins
      ;;
     -jc|--jenkins-c)
      jenkins_container
      ;;
    -p|--packages)
      packages
      ;;
     -s|--sonarqube)
      sonarqube
      ;;
    -n|--nexus)
      nexus
      ;;
     -post|--postgres)
      postgres
      ;;



    -rm|--docker-rm)
      remove_containers
      ;;
    -rmi|--docker-rmi)
      remove_images
      ;;
    -all|--del)
      remove_all
      ;;
    *)
      echo "Unknown option: ${opt} - Please run 'bash ${0##*/} -h' for help.">&2
      exit 1
  esac
}

# PACKAGES INSTALLION
packages() {
    apt update -y && apt upgrade -y
    which docker &>/dev/nul || { apt install docker.io -y; } 
    which docker-compose &>/dev/nul || { apt install docker-compose -y; } 
    which git &>/dev/nul || apt install git -y
    which curl &>/dev/nul || apt install curl -y 
    which unzip &>/dev/nul || apt install unzip -y 
}


# REMOVE CONTAINERS
remove_containers() {
    docker rm -f $(docker ps -aq)
    docker ps -a 
}

# REMOVE IMAGES
remove_images() {
    docker rmi -f $(docker images -aq) 
    docker images
}

# REMOVE IMAGES AND CONTAINERS
remove_all() {
    docker rm -f $(docker ps -aq) 
    docker rmi -f $(docker images -aq)
    # docker system prune -a
    docker images
    docker ps -a 
}


# JENKINS INSTALLATION THE CONTAINER
jenkins_container() {
    echo
    echo "Installing Jenkins"

    echo "2 - Create docker-compose file"
    echo "
    version: '3'
    services:
      jenkins:
        image: 'jenkins/jenkins:lts'
        container_name: jenkins
        user: 0:0
        ports:
          - '8070:8080'
          - '443:8443'
          - '50000:50000'
        volumes:
          - 'jenkins_data:/var/jenkins_home/'
        networks:
         - generator
    volumes:
      jenkins_data:
        driver: local
        driver_opts:
          o: bind
          type: none
          device: ${DIR}/jenkins/
    networks:
      generator:
       driver: bridge

    " >$DIR/docker-compose-jenkins.yml

    echo "3 - Run jenkins "
    docker-compose -f $DIR/docker-compose-jenkins.yml up -d
    echo
    echo "Getting Jenkins password ..................................."
    sleep 10
    echo -e "
    \033[1;32m
    docker exec -it [Running Container ID or name] cat /var/jenkins_home/secrets/initialAdminPassword
    docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
    \033[0m
    "

    sleep 5
    JENKINS_PPASSWORD=`docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword`
    echo -e "
    \033[1;36m
    Plase use this password to unlock Jenkins: ${JENKINS_PPASSWORD}
    \033[0m
    "

    echo -e "
    \033[1;36m
    Use the below URL to access Jenkins if Jenkins is runing in Vmware or VirtualBox
    http://${LOCALHOST_IP}:8070 
    \033[0m
    "

    echo -e "
    \033[1;36m
    Use the below URL to access jenkins if Jenkins is runing in AWS EC2 or Azure
    NB: The below will print your public IP if your Virtual machine is not in the cloud
    http://${CLOUD_PUBLIC_IP}:8070
    \033[0m
    "
    echo
    echo "Checking running containers................Please wait.................."
    sleep 3
    docker ps
}


# JENKINS INSTALLATION IN THE VM
jenkins_2() {

# cat << EOF  > $DIR/jenkins-install.sh
echo "
    #! /bin/bash
    OS=`cat /etc/os-release |grep PRETTY_NAME | awk -F= '{print$2}' | awk -F '"' '{print$2}' |awk '{print$1}'`
    # This script will install java and jenkins
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
" > $DIR/jenkins-install.sh

    chmod +x $DIR/jenkins-install.sh
    bash $DIR/jenkins-install.sh

    PASSWORD=`cat /var/lib/jenkins/secrets/initialAdminPassword`
    echo -e "
    \033[1;36m
    Please use this password to unlock Jenkins: ${PASSWORD}
    http://${LOCALHOST_IP}:8080 
    \033[0m
    "

    echo -e "
    \033[1;36m
    Use the below URL to access Jenkins if Jenkins is runing in Vmware or VirtualBox
    http://${LOCALHOST_IP}:8080 
    \033[0m
    "

    echo -e "
    \033[1;36m
    Use the below URL to access jenkins if Jenkins is runing in AWS EC2 or Azure
    NB: The below will print your public IP if your Virtual machine is not in the cloud
    http://${CLOUD_PUBLIC_IP}:8080
    \033[0m
    "
}


# JENKINS INSTALLATION IN THE VM
jenkins() {

    cd $DIR/
    git clone https://github.com/leonardtia1/Devops-easy-learning-software-installation.git
    chmod +x $DIR/Devops-easy-learning-software-installation/jenkins-script-installation.sh
    bash $DIR/Devops-easy-learning-software-installation/jenkins-script-installation.sh

    echo "Checking login information--------Please wait ---------"
    sleep 5
    
    echo -e "
    \033[1;36m
    Use the below URL to access Jenkins if Jenkins is runing in Vmware or VirtualBox
    http://${LOCALHOST_IP}:8080 
    \033[0m
    "

    echo -e "
    \033[1;36m
    Use the below URL to access jenkins if Jenkins is runing in AWS EC2 or Azure
    NB: The below will print your public IP if your Virtual machine is not in the cloud
    http://${CLOUD_PUBLIC_IP}:8080
    \033[0m
    "
    
    PASSWORD=`cat /var/lib/jenkins/secrets/initialAdminPassword`
    echo -e "
    \033[1;36m
    Please use this password to unlock Jenkins: ${PASSWORD}
    \033[0m
    "
}



# SONARQUBE INSTALLATION
sonarqube() {
    echo
    echo "Installing Sonarqube"

    echo "1 - Create directories ${DIR}/sonarqube/"
    mkdir -p $DIR/sonarqube/

    echo "2 - Create docker-compose file"
    echo "
    version: '3'
    services:
      sonarqube:
        image: 'sonarqube'
        container_name: sonarqube
        ports:
          - '9000:9000'
        volumes:
          - 'sonarqube_data:/opt/sonarqube'
        networks:
         - generator
    volumes:
      sonarqube_data:
        driver: local
        driver_opts:
          o: bind
          type: none
          device: ${DIR}/sonarqube/
    networks:
      generator:
       driver: bridge

    " >$DIR/docker-compose-sonarqube.yml

    echo "3 - Run sonarqube "
    docker-compose -f $DIR/docker-compose-sonarqube.yml up -d

    echo
    echo "Checking login information--------Please wait ---------"
    sleep 5
    
    echo -e "
    \033[1;36m
    Use the below URL to access Sonarqube if Sonarqube is runing in Vmware or VirtualBox
    http://${LOCALHOST_IP}:9000
    \033[0m
    "

    echo -e "
    \033[1;36m
    Use the below URL to access Sonarqube if Sonarqube is runing in AWS EC2 or Azure
    NB: The below will print your public IP if your Virtual machine is not in the cloud
    http://${CLOUD_PUBLIC_IP}:9000 
    \033[0m
    "

    echo -e "
    \033[1;36m
    Sonarqube default username and password
    username: admin
    password: admin
    \033[0m
    "
    echo
    echo "Checking running containers................Please wait.................."
    sleep 3
    docker ps
}


# NEXUS INSTALLATION
nexus() {
    echo
    echo "Installing Nexus"

    echo "1 - Create directories ${DIR}/nexus/"
    mkdir -p $DIR/nexus/

    echo "2 - Create docker-compose file"
    echo "
    version: '3'
    services:
      nexus:
        image: 'sonatype/nexus3'
        container_name: nexus
        ports:
          - '8081:8081'
        volumes:
          - 'nexus_data:/opt/sonatype/nexus'
        networks:
         - generator
    volumes:
      nexus_data:
        driver: local
        driver_opts:
          o: bind
          type: none
          device: ${DIR}/nexus/
    networks:
      generator:
       driver: bridge

    " >$DIR/docker-compose-nexus.yml

    echo "3 - Run nexus "
    docker-compose -f $DIR/docker-compose-nexus.yml up -d

    echo
    echo "Getting Nexus password ..................................."
    sleep 10
    echo -e "
    \033[1;32m
    docker exec -it [Running Container ID or name] cat /nexus-data/admin.password
    docker exec -it nexus cat /nexus-data/admin.password
    docker exec -it nexus cat /nexus-data/admin.password
    \033[0m
    "
    echo
    echo "Checking login information--------Please wait ---------"
    sleep 5

    NEXUS_PPASSWORD=`docker exec -it nexus cat /nexus-data/admin.password`
    echo -e "
    \033[1;36m
    Plase use this password to unlock Nexus: ${NEXUS_PPASSWORD}
    \033[0m
    "

    echo -e "
    \033[1;36m
    Use the below URL to access Nexus if Nexus is runing in Vmware or VirtualBox
    http://${LOCALHOST_IP}:8081
    \033[0m
    "

    echo -e "
    \033[1;36m
    Use the below URL to access Nexus if Nexus is runing in AWS EC2 or Azure
    NB: The below will print your public IP if your Virtual machine is not in the cloud
    http://${CLOUD_PUBLIC_IP}:8081 
    \033[0m
    "

    echo -e "
    \033[1;36m
    Nexus default username and password
    username: admin
    password: ${NEXUS_PPASSWORD}
    \033[0m
    "
    
    echo
    echo "Checking running containers................Please wait.................."
    sleep 10
    docker ps
}


# POSTGRES AND PGADMIN INSTALLATION
postgres() {
    echo
    echo "Installing Postgres and Pgdamin"

    echo "1 - Create directories ${DIR}/postgres/"
    mkdir -p $DIR/postgres/

    echo "2 - Create docker-compose file"
    echo "
    version: '3'
    services:
      postgres:
        image: 'postgres'
        container_name: postgres
        hostname: postgres
        ports:
          - '5432:5432'
        volumes:
          - 'postgres_data:/var/lib/postgresql/data'
        environment:
          POSTGRES_USER: postgres
          POSTGRES_PASSWORD: postgres
          POSTGRES_DB: TEST_SM
        restart: unless-stopped
        networks:
         - generator

      pgadmin:
        image: dpage/pgadmin4
        container_name: pgadmin
        depends_on:
          - postgres
        ports:
          - '5555:80'
        environment:
          PGADMIN_DEFAULT_EMAIL: pgadmin4@pgadmin.org
          PGADMIN_DEFAULT_PASSWORD: admin
        networks:
         - generator
        restart: unless-stopped
    volumes:
      postgres_data:
        driver: local
        driver_opts:
          o: bind
          type: none
          device: ${DIR}/postgres/
    networks:
      generator:
       driver: bridge

    " >$DIR/docker-compose-postgres-pgadmin.yml

    echo "3 - Run postgres "
    docker-compose -f $DIR/docker-compose-postgres-pgadmin.yml up -d

    echo
    echo "Checking login information--------Please wait ---------"
    sleep 10

    echo -e "
    \033[1;32m
    Connection through CLI:
    docker exec -it [Running Container ID or name] psql --host=postgres --username=postgres dbname=TEST_SM
    docker exec -it postgres psql --host=postgres --username=postgres dbname=TEST_SM
    \033[0m
    "

    echo -e "
    \033[1;36m
    Use the below URL to access Pgdamin if Pgdamin is Pgdamin in Vmware or VirtualBox
    http://${LOCALHOST_IP}:5555
    \033[0m
    "

    echo -e "
    \033[1;36m
    Use the below URL to access Pgdamin if Pgdamin is runing in AWS EC2 or Azure
    NB: The below will print your public IP if your Virtual machine is not in the cloud
    http://${CLOUD_PUBLIC_IP}:5555 
    \033[0m
    "

    echo -e "
    \033[1;36m
    Pgdamin default username and password
    username: pgadmin4@pgadmin.org
    password: admin
    \033[0m
    "

    echo -e "
    \033[1;36m
    Postgres default username and password
    username: postgres
    password: postgres
    \033[0m
    "

    echo
    echo "Checking running containers................Please wait.................."
    sleep 10
    docker ps
}

options $@








