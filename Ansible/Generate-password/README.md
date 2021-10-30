## How To Generate a /etc/passwd password hash via the Command Line on Linux?
If you’re looking to generate the /etc/shadow hash for a password for a Linux user (for instance: to use in a Puppet manifest), you can easily generate one at the command line.

### MD5 HASH
```
$ openssl passwd -1
Password:
Verifying - Password:
$1$3JUKmV3R$vZVeb51f1t6QZUecwuRHX0
```
By default, this will use an `md5` algoritme for your password hash. The openssl tool only allows for those md5 hashes, so if you’re looking for a more secure `sha256` hash you can use this python script as shared by Red Hat.

### SHA256 HASH
12345 = password
```
$ python -c "import crypt; print crypt.crypt('12345')"
$6$0LNgXS95nJv2B6hm$BRNf00hyT5xGNRnsLSSn3xDPXIs6l34g2kpex4mh0w/fvGz4MYs02qWjVU5NrbVktoNVNRsHU6MUTUua4J5nO0
```

### Create a user john with the password “12345”
$ ansible all -m user -a 'name=john password=$1$gZ0cD2Vf$HzaKPE4.KvJVZPv9Qdg4A. state=present' -b

### sha in Linux
```sh
# Generate MD5 password hash:
python -c "import random,string,crypt;
randomsalt = ''.join(random.sample(string.ascii_letters,8));
print crypt.crypt('MySecretPassword', '\$1\$%s\$' % randomsalt)"
---
$1$YjOzcqrf$Zqx4sx5CQRuEIFCdOLAJV0
 
# Generate SHA-256 password hash:
python -c "import random,string,crypt;
randomsalt = ''.join(random.sample(string.ascii_letters,8));
print crypt.crypt('MySecretPassword', '\$5\$%s\$' % randomsalt)"
---
$5$LgsPuaeR$OCtm.3tpbS/wyOZAIy6dsVNP4x0GyohyGebkIz15e88
 
# Generate SHA-512 password hash:
python -c "import random,string,crypt;
randomsalt = ''.join(random.sample(string.ascii_letters,8));
print crypt.crypt('MySecretPassword', '\$6\$%s\$' % randomsalt)"
---
$6$HMpFTkgb$WqzuqMqYbjWsXFrOtvZPo.1gIkH6HiXJGr4QPv.k26jE.3mE.sdf3ddsOZAIy6dsVNP4x0GyohyGebkIz15e88
```

![](/images/ans8.JPG)