#!/bin/bash

read -r -p 'Commit message: ' desc  # prompt user for commit message
git add .                           # track all files
git add -u                          # track deletes
git commit -m "$desc"               # commit with message
git push origin master              # push to origin


#!/bin/bash
read -r -p 'Commit message: ' COMMIT_MESSAGE
read -r -p 'Commit message: ' BRANCH_NAME  

git status
git add .                                                
git commit -m "$COMMIT_MESSAGE"               
git push -u "$BRANCH_NAME"              
