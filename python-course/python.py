import sys
import time
import os
import subprocess

UBUNTU = subprocess.run("""cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}'""",
                        shell=True,
                        capture_output=True,
                        text=True)

CENTOS = subprocess.run("""cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}' |awk -F" " '{print$2}' |awk -F'"' '{print$1}'""",
                        shell=True,
                        capture_output=True,
                        text=True)

AWS_CENTOS = subprocess.run("""cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}' |awk -F" " '{print$3}' |awk -F'"' '{print$1}'""",
                            shell=True,
                            capture_output=True,
                            text=True)

print(UBUNTU.stdout)
print(CENTOS.stdout)
print(AWS_CENTOS.stdout)

if print(UBUNTU.stdout) == "debian":
    print(f"This is {UBUNTU.stdout} or Ubuntu server")
elif CENTOS.stdout == "fedora":
    print(f"This is {CENTOS.stdout} or CentOs server")
elif AWS_CENTOS.stdout == "fedora":
    print(f"This is AWS EC2 or CentOs server")
else:
    print("Unknow Linux distribution")


#!/usr/bin/python3

UBUNTU = os.system("cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}'")

CENTOS = os.system(
    """cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}' |awk -F" " '{print$2}' |awk -F'"' '{print$1}'""")

AWS_CENTOS = os.system(
    """cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}' |awk -F" " '{print$3}' |awk -F'"' '{print$1}'""")

print(UBUNTU)
print(CENTOS)
print(AWS_CENTOS)

if os.system("cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}'") == "debian":
    print("yes")

if UBUNTU == 0:
    print(f"This is Ubuntu server")
elif CENTOS == "fedora":
    print(f"This is CentOs server")
elif AWS_CENTOS == "fedora":
    print(f"This is AWS EC2 or CentOs server")
else:
    print(f"Unknow Linux distribution")


#!/usr/bin/python3
CMD = "cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}'"
SP1 = subprocess.Popen(CMD, shell=True)
SP2 = SP1.wait()
out, err = SP2.communicate()

print(f"Disk available: {out}")


#!/usr/bin/env python3
OS = "cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}'"
sp = subprocess.Popen(OS, shell=True,
                      stdout=subprocess.PIPE,
                      stderr=subprocess.PIPE,
                      text=True,
                      universal_newlines=True)
rc = sp.wait()
out, err = sp.communicate()

print(f'The return code is: {rc}')
print(f'The error is: {err}')
print(f'The output is: {out}')
print(out)

if out == "debian":
    print(f"This is Ubuntu Linux OS")
if rc != 0:
    print("The command did not run well!")
elif str(out) == "debian":
    print(f"This is {out} or Ubuntu Linux OS")
else:
    print("Hummmmmmmmmm")


#!/usr/bin/env python3


USERS = '''
kareen
jires
TIA
biky
abdou
'''.lower().split()


print(USERS)

for i in USERS:
    sp = subprocess.Popen(["id", i], shell=False, stdout=subprocess.PIPE,
                          stderr=subprocess.PIPE, universal_newlines=True)
    rc = sp.wait()
    out, err = sp.communicate()

    if rc == 0:
        time.sleep(3)
        print("User {0} is already exist on this server".format(i))
    else:
        time.sleep(3)
        print("Adding user {0} ---------Please wait ----------".format(i))
        subprocess.run(["useradd", i], check=True)
        os.system("mkdir - p /home/{i}")
        os.system("ls /home/")


# function user_add() {
#     for users in $username
#     do
#     ls / home | grep $users & >/dev/nul | | mkdir - p / home /$users
#     cat / etc/passwd | awk - F: '{print$1}' | grep - w $users & >/dev/nul | |  useradd $users
#     chown - R $users: $users /home/,
#     usermod - s / bin/bash - aG docker $users
#     echo - e "$users\n$users" | passwd "$users"
#     # passwd --expire $users
#     done
# }


# password_expire() {
#     for users in $username
#     do
#     passwd - -expire $users
#     done
# }

# user_del() {
#     for users in $username
#     do
#     userdel - r - f $users
#     done
# }

# docker_run() {
#     docker rm - f $USER | | true
#     docker run - d - -name $USER - -privileged - v / sys/fs/cgroup: / sys/fs/cgroup: ro - v / var/run/docker.sock: / var/run/docker.sock - v "${HOME}": / student_home - w "/student_home" ${IMAGE_TAG}
#     docker exec - it $USER bash
# }
