#!/bin/bash

username=$(cat /tmp/users.txt | tr '[A-Z]' '[a-z]')

cat /etc/group |grep -E -w -o admin &>/dev/nul ||  groupadd admin
cat /etc/sudoers |grep -E -w -o admin &>/dev/nul || echo "%admin  ALL=(ALL)       ALL" >> /etc/sudoers  
function user_add() {
    for users in $username
    do
        cat /etc/passwd |awk -F: '{print$1}' |grep -w $users &>/dev/nul ||  useradd $users
        usermod -aG admin $users
        # cat /etc/group |grep -E -w -o docker &>/dev/nul ||  usermod -aG docker $users
        echo -e "$users\n$users" |passwd "$users"
        # passwd --expire $users
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
      -l | --lock)
      user_lock
      ;;
      -u | --unlock)
      user_unlock
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
