### How to Install Visual Studio Code on CentOS 7
* [How to Install Visual Studio Code on CentOS 7](https://linuxize.com/post/how-to-install-visual-studio-code-on-centos-7/)
* Start by importing the Microsoft GPG key:
```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
```
* Next, create the following repo file to enable the Visual Studio Code repository:
* vim /etc/yum.repos.d/vscode.repo and Paste the following content into the file:
```
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
```
* Once the repository is enabled, install the latest version of Visual Studio Code by typing
```
yum install code -y
```
* Starting Visual Studio Code 
Now that VS Code is installed on your CentOS system you can launch it either from the command line by typing `code` or by clicking on the VS Code icon (Applications -> Programming -> Visual Studio Code).

### How to Install Visual Studio Code on Ubuntu 20.04
```
apt update -y
snap install --classic code
code  --user-data-dir
```
### Wrap code on the same windows
```
alt + z in windows 
command + z in MAC 
```

### Block mode in Vs Code
```
alt + shift in windows 
command + shift in MAC 
```
```
kubectl describe po  pod-name -namespce dev1 |grep -i image
kubectl describe po  pod-name -namespce dev1 |grep -i image
kubectl describe po  pod-name -namespce dev1 |grep -i image
kubectl describe po  pod-name -namespce dev1 |grep -i image
kubectl describe po  pod-name -namespce dev1 |grep -i image
kubectl describe po  pod-name -namespce dev1 |grep -i image
kubectl describe po  pod-name -namespce dev1 |grep -i image
```

### Change all occurences
```
ctrl + f2
```
You can also select the word the you want to change all occurence in the file, right click on ckoose `Change all occurences` and change everything as once.

### Search recursive in folder and replace
![](/images/vs-search.JPG)


