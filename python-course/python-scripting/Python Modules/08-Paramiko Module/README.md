## Working with remote Linux Server from Linux/Windows using paramiko of python

### Paramiko Module(Used to work with remote servers):
- Paramiko module will create a SSH Client and by using this it will connect to remote server and executes commands.
- we can also transfer files from the remote machine to the local or vice versa using paramiko.

- Two ways to connect with remote server:
    - Using username and password
    - Using username and cryptographic key
    - We connect to Linux/Windows <-> Linux/Windows

### Working with remode server
- Transfer a file from local server to remote server and vice versa using paramiko of python
- Executing commands on Remote server from Local server Using Python Paramiko module -  Working with remote Linux Server from Linux/Windows using python paramiko Local server: Linux/Windows Remote Server: Linux

### installing paramiko on windows on linux
```sh
python3 -m pip install --upgrade pip or python -m pip install --upgrade pip
pip3 install paramiko or pip install paramiko
```

### Paramiko template
```py
#!/bin/python
import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
# password authentification
ssh.connect(hostname='Server IP or Hostname',username='Login name',password='User password',port=SSH Port)
# password less authentification
ssh.connect(hostname='Server IP or Hostname',username='Login name',key_filename='Private key path',port=SSH Port)
stdin, stdout, stderr = ssh.exec_command('Command to run on the remote server')
stdin = for sudo or input on remote server
stdout = output variable
stderr = error variable
print(stdout.readlines())
OR
print(stdout.read())

ssh.close()
```

### Read option
```py
import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
# password authentification
ssh.connect(hostname='10.0.0.31' ,username='root',password='12345',port=22)
stdin, stdout, stderr = ssh.exec_command('whoami')
print('The output is:')
print(stdout.read())

print('The error is:')
print(stderr.read())
ssh.close()

#OUTPUT
$ python a.py
The output is:
b'root\n'
The error is:
b''
```

### Read lines option
```py
import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
# password authentification
ssh.connect(hostname='10.0.0.31' ,username='root',password='12345',port=22)
stdin, stdout, stderr = ssh.exec_command('cat /etc/*release')
print('The output is:')
print(stdout.readlines())

print('The error is:')
print(stderr.readlines())
ssh.close()

#OUTPUT
The output is:
['CentOS release 6.4 (Final)\n', 'LSB_VERSION=base-4.0-ia32:base-4.0-noarch:core-4.0-ia32:core-4.0-noarch:graphics-4.0-ia32:graphics-4.0-noarch:printing-4.0-ia32:printing-4.0-noarch\n', 'CentOS release 6.4 (Final)\n', 'CentOS release 6.4 (Final)\n']
The error is:
[]
```

### Installing package
```py
import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
# password authentification
ssh.connect(hostname='10.0.0.31' ,username='root',password='12345',port=22)
stdin1, stdout1, stderr1 = ssh.exec_command('yum -y install git')
stdin2, stdout2, stderr2 = ssh.exec_command('git --version')

print('The output is:')
print(stdout2.readlines())
ssh.close()

#OUTPUT
$ python a.py
The output is:
['git version 1.7.1\n']
```

### Add user
```py
import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
# password authentification
ssh.connect(hostname='10.0.0.31' ,username='root',password='12345',port=22)
stdin2, stdout2, stderr2 = ssh.exec_command('useradd paramiko')
stdin3, stdout3, stderr3 = ssh.exec_command('cat /etc/passwd |grep paramiko')
print('The output is:')
print(stdout3.readlines())
ssh.close()

#OUTPUT
$ python a.py
The output is:
['paramiko:x:505:505::/home/paramiko:/bin/bash\n']
```

### Password less authentification
```py
#!/bin/python
import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
#ssh.connect(hostname='3.92.79.119',username='ec2-user',password='paramiko123',port=22)
ssh.connect(hostname='3.92.79.119',username='ec2-user',key_filename='/home/Automation/.ssh/id_rsa',port=22)
#stdin, stdout, stderr = ssh.exec_command('whoami')
#stdin, stdout, stderr = ssh.exec_command('uptime')
stdin, stdout, stderr = ssh.exec_command('free -m')
print("The output is: ")
print(stdout.readlines())

print("THe error is: ")
print(stderr.readlines())
ssh.close()
```

### Transfert file from local server to remote and remote to local template
```py
import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(hostname='54.165.97.91',username='ec2-user',password='paramiko123',port=22)
sftp_client=ssh.open_sftp()

sftp_client.put("transfer_files.py",'/home/ec2-user/transfer_files.py')
sftp_client.close()
ssh.close()
# Do not close ssh first because sftp_client depends on ssh
```

### put is use to tranfert file to a remote server
```py
import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(hostname='10.0.0.31',username='root',password='12345',port=22)
sftp_client=ssh.open_sftp()

sftp_client.put("C:\\Users\\Owner\\Downloads\\a.py",'/tmp/script.py')
#sftp_client.put("C:\\Users\\Owner\\Downloads\\a.py",'/a.py')
sftp_client.close()
ssh.close()
```

### Get is use to download file remote server to local
```py
import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(hostname='10.0.0.31',username='root',password='12345',port=22)
sftp_client=ssh.open_sftp()

sftp_client.get('/tmp/script.py', 'C:\\Users\\Owner\\Desktop\\script.py')
sftp_client.close()
ssh.close()
```

### Copy at shell script and run it on the target server
```sh
cat httpd.sh
#!/bin/bash
yum -y install httpd
Service httpd start
yum -y install tree
yum -y install git
useradd paul
```
```py
import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(hostname='10.0.0.31',username='root',password='12345',port=22)
sftp_client=ssh.open_sftp()

sftp_client.put("C:\\Users\\Owner\\Downloads\\httpd.sh",'/tmp/httpd.sh')
stdin1, stdout1, stderr1 = ssh.exec_command('chmod +x /tmp/httpd.sh')
stdin2, stdout2, stderr2 = ssh.exec_command('bash /tmp/httpd.sh')
stdin3, stdout3, stderr3 = ssh.exec_command('cat /etc/passwd |grep paul')
print('The output is:')
print(stdout3.readlines())
ssh.close()

#OUTPUT
$ python a.py
The output is:
['paul:x:503:503::/home/paul:/bin/bash\n']
```

### Transfert file from local server to remote and remote to local
```py
import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(hostname='54.165.97.91',username='ec2-user',password='paramiko123',port=22)
sftp_client=ssh.open_sftp()
# Download a file
sftp_client.get('/home/ec2-user/paramiko_download.txt','paramiko_downloaded_file.txt') 
# change dir
sftp_client.chdir("/home/ec2-user") # change dir  
print(sftp_client.getcwd())
sftp_client.get('demo.txt','C:\\Users\\Automation\\Desktop\\download_file.txt')
sftp_client.put("transfer_files.py",'/home/ec2-user/transfer_files.py')
sftp_client.close()
ssh.close()
```