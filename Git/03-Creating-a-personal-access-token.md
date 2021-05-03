### Personal Access Token in Git
- [Creating a personal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token#using-a-token-on-the-command-line)

- Personal access tokens (PATs) are an alternative to using passwords for authentication to GitHub when using the GitHub API or the command line.

- You should create a personal access token to use in place of a password with the command line or with the API.

- As a security precaution, GitHub automatically removes personal access tokens that haven't been used in a year.

- Personal access tokens can only be used for HTTPS Git operations. If your repository uses an SSH remote URL, you will need to switch the remote from SSH to HTTPS.

### Using a token on the command line
- Once you have a token, you can enter it instead of your password when performing Git operations over HTTPS.
- For example, on the command line you would enter the following:
```
$ git clone https://github.com/username/repo.git
Username: your_username
Password: your_token
```

