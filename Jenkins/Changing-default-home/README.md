### How to change Jenkins Default home directory
- a : Preserve the specified attributes such as directory and file mode, ownership, timestamps, if possible additional attributes: context, links, xattr, all.
- v : Verbose output.
- r : Copy directories recursively.
```sh
systemctl stop jenkins
mkdir /jenkins_home
chown jenkins:jenkins /jen_kinshome
cat /etc/passwd |grep jenkins
usermod -d /jenkins_home jenkins
cat /etc/passwd |grep jenkins
rsync -av /var/lib/jenkins /jenkins_home/
```
* Change the default home in `/etc/sysconfig/jenkins`
```
vim /etc/sysconfig/jenkins
JENKINS_HOME="/jenkins_home" (:wq)
systemctl restart jenkins
```
* Copy jobs and restart Jenkins
```
cp -av /var/lib/jenkins/jobs /jenkinshome/jobs
systemctl restart jenkins
```
