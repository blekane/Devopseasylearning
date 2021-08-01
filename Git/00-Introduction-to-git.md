# Introduction to Git

## Scenario Without VCS (Version Control System)
- Once the code is saved, all the changes made in the file are permanent and cannot be reverted back
- No record of what was done by whom

**Dave** is working on a new feature
![](/images/git1.JPG)

Client didn’t like the new feature
![](/images/git2.JPG)

**Dave** delete the code and continue with the development
![](/images/git3.JPG)

Client change his mind and want that feature back
![](/images/git4.JPG)

## Same Scenario With VCS (Version Control System)
**Dave** is working on a new feature
![](/images/git1.JPG)

Client didn’t like the new feature
![](/images/git5.JPG)

**Dave** delete the code and continue with the development and client change his mind and want that feature back
![](/images/git6.JPG)

**Dave** is happy because of VCS
![](/images/git7.JPG)

## What Is VCS (Version Control System)?
- **VCS** is a system that document changes made to a file or a set of files. It allows multiple users to manage multiple revision of the same unit of information. 
- A version control system records changes carried out to a file, or a set of files over time, and helps you to recall specific versions of the code later on when you need it. If you’re a developer or a web designer and want to keep track of each and every version of your code developed for a particular feature, a Version Control System “VCS” allows you to:
    - Revert the code files back to their previous state
    - Recall and revert the entire project back to its previous state
    - Compare code changes over specific durations of time
    - Find who last modified a piece of code that might be causing an issue or a problem
    - Who introduced a particular issue and when
    
![](/images/git8.JPG)

## What is Git?
**Git** is the most popular and widely used version control system today. Originally developed as an open source project in 2005 by the creator of the Linux operating system, it is a matured and actively maintained environment. A huge number of developers rely upon Git version controlling to develop several types of commercial and non-commercial projects.

## Git Workflow
![](/images/git9.JPG)

## Centralized VCS and Distributed VCS
[Centralized vs Distributed Version Control: Which One Should We Choose](https://www.geeksforgeeks.org/centralized-vs-distributed-version-control-which-one-should-we-choose/)

- Distributed VCS: 
    - Git, 
    - Bitbucket 
    - etc.
- Centralized VCS: 
    - CVS, 
    - SVN etc.

![](/images/git10.JPG)

![](/images/git11.JPG)

## Git Workflow with branches
![](/images/git12.JPG)

## Merge Conflicts
**Dave** and Sam start a new feature on **v1.2**
![](/images/git13.JPG)

**Dave** is working on **v1.2** locally
![](/images/git14.JPG)

Sam  is also working on **v1.2** locally
![](/images/git15.JPG)

**Dave** push the code into the remote repository and Sam is having merge conflict with **Dave** code
![](/images/git16.JPG)

## Why merge conflicts occurs?
- Merge conflicts arise when two files with the same content is modified and merged.
- Merge conflicts can occur on merging branches
![](/images/git17.JPG)

## How to resolve merge conflicts?
- Merge conflicts are resolved manually by users
- We can use VS code also to compare and resolve merge conflicts
![](/images/git18.JPG)
