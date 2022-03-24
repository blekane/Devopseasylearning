#!/bin/bash

cat << EOF > /tmp/users.txt
tia
EOF
username=$(cat /tmp/users.txt | tr '[A-Z]' '[a-z]')
function user_add() {
    for users in $username
    do
        ls /home |grep -w $users &>/dev/nul || mkdir -p /home/$users 
        cat /etc/passwd |awk -F: '{print$1}' |grep -w $users &>/dev/nul ||  useradd $users
        chown -R $users:$users /home/$users
        usermod -s /bin/bash -aG docker $users
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

user_lock() {
    for users in $username
    do
        usermod -s /sbin/nologin $users
        cat /etc/passwd |grep $users
    done
}

user_unlock() {
    for users in $username
    do
        usermod -s /bin/bash $users
        cat /etc/passwd |grep $users
    done
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
      -l | --lock)
      user_lock
      ;;
      -u | --unlock)
      user_unlock
      ;;
      -r|--run|--run)
      docker_run
      ;;
      -m|--mkdir)
      mkdir
      ;;
    *)
      echo "Unknown option"
      exit 1
  esac
}

options $@


