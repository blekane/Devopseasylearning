# Git Basics

### Git installation
```
yum -y install git
apt-get install git -y
```

### Check if git is install
```
git --version
```

### Initialize a new local empty repository
```
mkdir git
cd git
git init
```

### This will show you .git which means local repo
```
ls -a
```

### What is the folder called .git?
```
tree .git
```
- The `.git `folder is the directory which is created when you do `git init` `.git `folder makes your project a "git" repository. Without `.git`, your project is a local project and not a git project, that means you cannot perform any git operations.

- The .git folder contains all the information that is necessary for your project in version control and all the information about commits, remote repository address, etc. All of them are present in this folder. It also contains a log that stores your commit history so that you can roll back to history.

- git stores the metadata and object database for the project in this directory like:
    - Remote information (to which remote server your project is connected)
    - History of all local commits
    - Branch information (on which branch is your current project state (HEAD) pointing to)
    - All logs of all local commits you have ever made (including revert changes)
    - The config file will hold all the configuration


### Add you name and email
This is to know who commited something when we type git log

**Add you name**
```
git config --global user.name "Your Name"
git config --global user.name "Tia M"
```

**Add you email**
```
git config --global user.email "your email address"
git config --global user.email "tia@gmail.com"
```

### List the global configuration
```
git config --list
or 
cat ~/.gitconfig
```

### Create a new repo in Github
[How to create a repository in github](https://docs.github.com/en/github/getting-started-with-github/create-a-repo)
- Create a new repository
- Repository name Add a README file


### What is .gitignore file in Git?
[Ignoring files](https://docs.github.com/en/github/getting-started-with-github/ignoring-files)

- You can configure Git to ignore files you don't want to check in to GitHub.
- You can create a .gitignore file in your repository's root directory to tell Git which files and directories to ignore when you make a commit.
```
$ touch .gitignore
```
```
# Terraform
**/.terraform/*
terraform.tfvars
*.tfstate
*.tfstate.*
*.terraform
backend.tf
provider.tf
```

### What is a README file in Git?
- [About READMEs](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/about-readmes)

- You can add a **README** file to your repository to tell other people why your project is useful, what they can do with your project, and how they can use it.

- **A README** is often the first item a visitor will see when visiting your repository. README files typically include information on:
    - What the project does
    - Why the project is useful
    - How users can get started with the project
    - Where users can get help with your project
    - Who maintains and contributes to the project


### How to delete a repository in github?
[Deleting a repository](https://docs.github.com/en/github/administering-a-repository/deleting-a-repository)

1. On GitHub, navigate to the main page of the repository.
2. Under your repository name, click Settings.
3. Under Danger Zone, click Delete this repository.
4. Read the warnings.
5. To verify that you're deleting the correct repository, type the name of the repository you want to delete and hit delete


### Create a new repo in Github without README file
- Create a new repository
- Repository name and hit create

### Create a new repository on the command line
```
echo "# test" >> README.md
git init
git add README.md or git add .
git status
git commit -m "first commit"
git branch -M main
git branch -a
git remote add origin https://github.com/leonardtia1/test.git
git push -u origin main
```

### Push an existing repository from the command line
```
git remote add origin https://github.com/leonardtia1/test.git
git branch -M main
git push -u origin main
```