#!/bin/bash

cat << EOF > /tmp/users.txt
benji
bill
blandine 
yannick 
cedric
nigieu
claude 
ekow
francois 
georges
geradine 
gislaine
guillaume
henry
igor
jamin 
michel
kelly
leonel 
achille 
linda
marietta
michelle
amy
nelly
patrick
peter
raissa
rodrigue
ousmane
steph
will
valdes
bruce
yolene
cyprien
jenny
valdez
arnaude
bernice
christian
vanel
alfred
ivo
philomene
stephane
noel
papys
idrissa
princess
lesly
adele
steve
duclair 
mireille
thierry
gertrude
chefer
eric2
sam
gabriel
sandra
amie
kareen
jires
biky
abdou
ingrid
benoit
kantin
carolle
gaelle
joel
joelle
simplice
lucy
jeanne
aniebiet
blondelle
kevin
serge
adedeji
king
grace2026
ernest
Arsene
hypolite
blaise
gueno
barbara
christelle 
henriette
ulrich
lulu
cediane
johnathan
bellsinclair
will
eric
tia
EOF



username=$(cat /tmp/users.txt | tr '[A-Z]' '[a-z]')

function user_add() {
    for users in $username
    do
        cat /etc/passwd |awk -F: '{print$1}' |grep -w $users &>/dev/nul ||  useradd $users
        usermod -aG docker $users
        echo -e "$users\n$users" |passwd "$users"
    done
}


password_expire() {
    for users in $username
    do
        passwd --expire $users
    done
}

user_del() {
    for users in $username
    do
        userdel -r -f $users
    done
}

docker_run() {
    docker rm -f $USER || true
    docker run -d --name $USER --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /var/run/docker.sock:/var/run/docker.sock -v "${HOME}":/student_home -w "/student_home" ${IMAGE_TAG}
    docker exec -it $USER bash
}

options() {
  case $@ in
    -a|--useradd|-add)
      user_add
     ;;
     -e|--expire|-ex)
      password_expire
      ;;
     -d|--userdel|--del)
      user_del
      ;;
      -r|--run|--run)
      docker_run
      ;;
    *)
      echo "Unknown option"
      exit 1
  esac
}

options $@
