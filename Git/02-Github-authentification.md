# Github authentification 

### 3 ways to authenticate Github:
    - Personal access token
    - Username and password (HTTPS: This is the default one)
    - SSH
**NB:** SSH is the most widley used by companies our there for Github authentification


### Github authentification with personal access token
[Creating a personal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token)

- Personal access tokens (PATs) are an alternative to using passwords for authentication to GitHub when using the GitHub API or the command line.

- You should create a personal access token to use in place of a password with the command line or with the API.

- As a security precaution, GitHub automatically removes personal access tokens that haven't been used in a year.

- Personal access tokens can only be used for HTTPS Git operations. If your repository uses an SSH remote URL, you will need to switch the remote from SSH to HTTPS.

**Using a token on the command line:**
- Once you have a token, you can enter it instead of your password when performing Git operations over HTTPS.
- For example, on the command line you would enter the following:
```
$ git clone https://github.com/username/repo.git
Username: your_username
Password: your_token
```

### Github Enterprise authentification with SSH
[Connecting to GitHub with SSH](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh)

**About SSH**
Using the SSH protocol, you can connect and authenticate to remote servers and services. With SSH keys, you can connect to GitHub without supplying your username and personal access token at each visit.

**Generating a new SSH key and adding it to the ssh-agent**
```
ssh-keygen -t ed25519 -C "your_email@example.com"
sh-keygen -t ed25519 -C "jean.paul@tcs.com"
cd /root/.ssh/
```

**Adding your SSH key to the ssh-agent**
```
$ eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```
**Add the SSH key to your GitHub account.**
```
cat /root/.ssh/id_ed25519.pub

ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBIWJDbpAkgztMeT2x/mUMTqPADK9Htt1LN3BmhOC8PG jean.paul@tcs.com
```

**Another way to authenticate github with ssh but not use by companies our there.**
```
mkdir -p /root/tmp/.ssh
ssh-keygen
/root/tmp/.ssh/id_rsa.pub
```