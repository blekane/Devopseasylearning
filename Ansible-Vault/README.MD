### Ansible Vault - Introduction | How Ansible Vaultworks | Learn Ansible Vault basic commands
[Ansible Vault](https://www.youtube.com/watch?v=L8GzW4sopug)
[Encrypting Files with Ansible Vault](https://www.youtube.com/watch?v=xeBnAbmt3Wk)
 
### To create and ansible vault in encrypted format
```
ansible-vault create 
ansible-vault create test.yml
```

```
bash-5.1# cat test.yml
$ANSIBLE_VAULT;1.1;AES256
37336239626639613062643337633063653031383139633539303930333031323531383033666465
3063383732336235626238633365383536316230333335330a633730653165323862303465306237
64333862613338343766626139363861653863366439623537346238393465313832393163383234
6365373430373335310a613464656538333439333034663037306266373462393863373666346266
3461
```

### To view the data
```
ansible-vault view 
ansible-vault view test.yml
```

### To edit the file
```
ansible-vault edit
ansible-vault edit test.yml
```

### To encrypt the data
```
ansible-vault encrypt
ansible-vault encrypt test.yml
```

### To decrypt the data
```
ansible-vault decrypt
ansible-vault decrypt test.yml
```

### To provide password while running the playbook
```
-- ask-vault-pass
ansible-playbook -- ask-vault-pass
```

### Tp pass a vault password through a file
````
-- vault-password-file
ansible-vault encrypt --vault-password-file ~/.vault_key password.txt
ansible-vault encrypt --vault-password-file ~/.vault_key password.txt 
````

1. Create the vault password and change the permission
```
bash-5.1# vi ~/.vault_key
bash-5.1# cat ~/.vault_key
12345
bash-5.1# chmod 600 ~/.vault_key
bash-5.1# ls -l cat ~/.vault_key
ls: cat: No such file or directory
-rw-------    1 root     root             6 Sep 22 02:30 /root/.vault_key
```

2. Create a file that you want to encrypt
```
bash-5.1# vi password.txt
bash-5.1# cat password.txt
IAYGGHJ
ydsgnf
dkdhjf
```
3. Encrypt the file using the vault password
```
bash-5.1# ansible-vault encrypt --vault-password-file ~/.vault_key password.txt Encryption successful
bash-5.1#

bash-5.1# cat password.txt
$ANSIBLE_VAULT;1.1;AES256
34316366336133633534333565366232306133373830313336383965383431633462633162333030
6362666436633735356437653137613431336133313335630a356666303638316561613035656562
65613339373462313133643139623164653535313964646464323961373233323931396565323437
3231646638623161630a316135343865333762643637316436393161623164616634613266656538
33633437653333383133356364336265323631383232316536343332636538653337
bash-5.1#
```
4. Decrypt the file using the vault password
```
bash-5.1# ansible-vault decrypt --vault-password-file ~/.vault_key password.txt
Decryption successful
bash-5.1#
```
```
ansible-vault encrypt --vault-password-file ~/.vault_key password.txt
ansible-vault decrypt --vault-password-file ~/.vault_key password.txt
ansible-vault edit --vault-password-file ~/.vault_key password.txt
ansible-vault view --vault-password-file ~/.vault_key password.txt
```