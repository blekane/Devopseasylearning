## Add Remote Ripository
[Managing remote repositories](https://docs.github.com/en/github/getting-started-with-github/managing-remote-repositories#:~:text=Use%20the%20git%20remote%20rm,remote%20name%2C%20for%20example%2C%20destination)

We can add multiple remote repositories and push the local repository to multiple remote repositories. Just change the origin such as origin 1, origin 2 and so on. The default is `origin`.
```
git remote add origin your_repo_url.git
git remote add origin https://github.com/leonardtia1/test.git
```

```
git remote add origin <remote address url repo 1>
git remote add origin_1 <remote address url repo 2>
git remote add origin_n <remote address url repo n>

git push -u origin master
git push -u origin_1 master
git push -u origin_n master
```

```
git remote add origin <your_repo_url.git>
git remote add origin_bitbucket <your_repo_url.git>

git remote add origin https://github.com/leonardtia1/test.git
git remote add origin_bitbucket https://leonardtia57@bitbucket.org/leonardtia57/test.git

git push -u origin main
git push -u origin_bitbucket main
```

**To check the remote repository added**
```
git remote -v
```

### Example using remote Ripository
- Create 2 repositories: one on Github and another one on Bitbucket
- Clone Github repostory
- Add some file and commit them into your local repository
- add Bitbucket remote url
- push the code into github and bitbucket repo
- **NB:** the code should be in main in bitbucket because when you create a new repository in bitbucket, it create a branch call `master` by default and the `main` by default in github. When we will push the code into bitbucket, it will create a new branch call `main` and stored the code in.

```
git clone git@github.com:leonardtia1/test.git
ls
test
vim file.txt
git add .
git commit -m "a"
git remote -v
git branch -a
git remote add origin_bitbucket https://leonardtia57@bitbucket.org/leonardtia57/test.git
git push -u origin main
git push -u origin_bitbucket main
```

### Managing remote repositories

**To check the remote repository added**
```
git remote -v
```

**Renaming a remote repository**
```
#View existing remotes*
$ git remote -v
> origin  https://github.com/OWNER/REPOSITORY.git (fetch)
> origin  https://github.com/OWNER/REPOSITORY.git (push)
```

**Change remote name from 'origin' to 'origin_git'**
```
$ git remote rename origin origin_git

$ git remote -v
> origin_git  https://github.com/OWNER/REPOSITORY.git (fetch)
> origin_git  https://github.com/OWNER/REPOSITORY.git (push)
```

```
[root@localhost test2]# git remote -v
origin_bitbucket        https://leonardtia57@bitbucket.org/leonardtia57/test.git (fetch)
origin_bitbucket        https://leonardtia57@bitbucket.org/leonardtia57/test.git (push)
origin_git              git@github.com:leonardtia1/test2.git (fetch)
origin_git              git@github.com:leonardtia1/test2.git (push)
```

**Removing a remote repository**
```
$ git remote -v
# View current remotes
> origin  https://github.com/OWNER/REPOSITORY.git (fetch)
> origin  https://github.com/OWNER/REPOSITORY.git (push)
> destination  https://github.com/FORKER/REPOSITORY.git (fetch)
> destination  https://github.com/FORKER/REPOSITORY.git (push)

$ git remote rm destination
$ git remote -v

# Verify it's gone
> origin  https://github.com/OWNER/REPOSITORY.git (fetch)
> origin  https://github.com/OWNER/REPOSITORY.git (push)
```
