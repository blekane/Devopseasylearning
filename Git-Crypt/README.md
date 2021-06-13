# Setting up git-crypt & GPG keys
```
man gnupg
```
**GnuPG**  is  a set of programs for public key encryption and digital signatures. The program most users will want to use is the OpenPGP command line tool, named gpg2.

## Install GnuPG on Ubuntu (to generate keys)
```
sudo apt-get install gnupg -y
```

## Install git-crypt on Ubuntu
```
apt install git-crypt
```

## Mac Installation
```
brew install git-crypt
brew install gpg
```

### list the key and location
```
gpg --list-keys
```

### Generate a gpg key
```
gpg --full-generate-key
```
```
# RSA is the default for Linux
Please select what kind of key you want:  
Your selection? 1

# Reduire the size to 2048 so that it will not take too much time to generate the key because it depends on your CPU speed.
RSA keys may be between 1024 and 4096 bits long:
What keysize do you want? (3072) 2048

# It is good to set the expiration date. 2m for 2 monhts, 2y for 2 years an so on.
Please specify how long the key should be valid: 
Key is valid for? (0) 2y

# Confirm
Is this correct? (y/N) y

# Your name
GnuPG needs to construct a user ID to identify your key.
Real name: Leonard Tia

# Put you work email if you are setting it at work
Email address: leonardtia57@yahoo.fr

# You can hit enter to skip command
Comment:

# Hit O for okay and enter your Passphrase
Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O

You need a Passphrase to protect your secret key: Devops@
```

### list the key and location
```
gpg --list-keys
```

### Change your GPG key’s passphrase
```
gpg --passwd leonardtia57@yahoo.fr
```

### Info about your gnupg
All info about your gnupg key is store in `.gnupg` folder. You backup everything in `.gnupg` if you to backup your key and copy somewhere. 

```
cd .gnupg
tar -cvf gnupg_backup.tar .

### Extract
tar -vxf gnupg_backup.tar 
```
![](/images/gp.JPG)

### Export the public key so that it can be added in github or in the code repo. 
You should be in your home directory where you have the `.gnupg` folder
```
gpg --armor --export [your email]
gpg --armor --export  leonardtia57@yahoo.fr
```
```
gpg --armor --export --output [file name].gpg [your email]
gpg --armor --export --output tia.gpg leonardtia57@yahoo.fr
```
 
## Let Encrypt a file with gpg 
**Create a file** 
```
mkdir test
cd test
echo "db_password=devops23@" >> password.txt
```
**Encrypt the file**
```
gpg -r [your email] -e [file name]
gpg -r leonardtia57@yahoo.fr -e password.txt
```
**Decrypt the file**
```
rm -rf password.txt
gpg -d [file name]
gpg -d password.txt.gpg
gpg -d password.txt.gpg > password.txt
```

## Initializing git-crypt in the repo
cd to the code repo and initialise git-crypt
```
git-crypt init
```

This will initialize `git-crypt` in the repository, but it does not encrypt any files by default. `git-crypt` uses the `.gitattributes` file to define what files it will manage. **Therefore**, you must first create the `.gitattributes` before creating the file you wish to encrypt. 

For the purposes of this example, let’s suppose that we want to encrypt a file called db_password.tf. Then we would need to add these lines in `.gitattributes`

```
secretfile filter=git-crypt diff=git-crypt
db_password.tf filter=git-crypt diff=git-crypt
```

**EXAMPLE:**
```
mkdir git-test
cd git-test
git init
touch .gitattributes
git-crypt init
echo "db_password=devops23@" >> db_password.tf
gpg --import /root/tia.gpg
git add .
git commit -m "1"
git-crypt unlock
git-crypt lock
```
![](/images/gp1.JPG)


## Importing the key
Anyone who is having the authority to add and edit git-crypt needs to import the key in order to add the user to the keyring. For this use gpg import command
```
gpg --import user_pubkey.gpg
```

This will add the key to the keyring. Next step is to add trust to the key.
```
gpg --edit–key D1F0A6846ED79975B9BDDAC29D0C9F2B2C08DA87
```

This will lead to a gpg prompt where you can get the fingerprint of the key by using fpr command
```
> fpr
```

Add trust level to user by trust command. It will ask for a trust level to select, add accordingly.
```
> trust
```

After verifying the fingerprint save changes by save command
```
> save
```

Quit the prompt by quit command
```
> quit
```

## Add user to the git-crypt repo
Now that you have added the collaborator’s public key to your keyring, all that’s left to do is add that key to the git-crypt credentials in your repo. You can do that with the command add-gpg-user.
```
git-crypt add-gpg-user --trusted D1F0A6846ED79975B9BDDAC29D0C9F2B2C08DA87
```