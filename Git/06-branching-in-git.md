### List branches (the asterisk indicate the current branch)
```
git branch
```

### List all branches (local and remote)
```
git branch -a
```

### Create a new branch
```
git branch [branch name]
git branch feature/EC-2511
```

### Delete a local branch
```
git branch -d [branch name]
git branch -D [branch name]
git branch -D feature/EC-2511
```

### Delete a remote branch
```
git push origin --delete [branch name]
```

### Create a new branch and switch to it
```
git checkout -b [branch name]
```

### Rename a local branch
```
git branch -m [old branch name] [new branch name]
git branch dev
git branch -m dev prod
```
### Switch to a branch
```
git checkout [branch name]
```

### Switch to the branch last checked out
```
git checkout -
```

### Merge a branch into a target branch
```
git merge [source branch] [target branch]
```

### Push a branch 
```
git push -u origin feature/EC-3060
```

### Renaming Git Branch
- Follow the steps below to rename a Local and Remote Git Branch:

    * list all the branches `git branch -a`

    * Start by switching to the local branch which you want to rename: `git checkout <old_name>`

    * Rename the local branch by typing: `git branch -m <new_name>`

    * Push the <new_name> local branch and reset the upstream branch: `git push origin -u <new_name>`

    * Delete the <old_name> remote branch: `git push origin --delete <old_name>`