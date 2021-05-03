
# Tagging in Git and Releases
- [Managing releases in a repository](https://docs.github.com/en/github/administering-a-repository/managing-releases-in-a-repository#creating-a-release)
- [Tagging in git](https://www.youtube.com/watch?v=govmXpDGLpo&list=PLrafTkhP5sZzKQd31XOslFxtrL2yBP2Yg&index=1)

### What are git tags?
Tags are **ref's** that point to specific points in Git history. Tagging is generally used to capture a point in history that is used for a ***marked version release (i.e. v1.0.1)***. A tag is like a branch that doesn’t change. Unlike branches, tags, after being created, ***have no further history of commits***. 

### When to create a tag in Git?
1. When you want to create a release point for a stable version of your code
2. When you want to create a history point for your code/data that you refer at any future time (to restore you data)

```sh
module "vpc" {
  source = "git::https://example.com/vpc.git?ref=v1.2.0"
}

module "vpc" {
  source = "git::https://example.com/vpc.git?ref=feature/EC-5350"
}
```

### Git Basics - Tagging
**Checkout the branch where you want to create the tag**
```
git checkout "branch name"
example : git checkout master
```

**Create tag with some name**
```
git tag -a "tag name" -m "reference of commit"
git tag "tag name" "reference of commit"
example: git tag -a v1.0.0 -m "DevOps Easy Learning Website release v1.0.0"
```

**Display or Show tags**
```
git tag
git show v1.0.0
```

**Push tags to remote**
```
git push -u origin <tag>
git push -u origin v1.0.0
```

**Delete tags from local**
```
git tag -d v1.0
git tag --delete v1.0
```

**Delete tags from remote**
```
git push -u origin -d v1.0
git push -u origin --delete v1.0
git push origin :v1.0
```

**Delete multiple tags at once**
```
git tag -d v1.0 v1.1 (local)
git push origin -d v1.0 v1.1 (remote)
```

**Checking out TAGS**
- We cannot checkout tags in git
- We can create a branch from a tag in Github (Example: feature/EC-2532) and run git pull
```
git branch -a
git pull
git checkout feature/EC-2532
```

**Creating TAGS from past commits**
```
git tag "tag name" "reference of commit"
example : git tag  v1.2 5fcdb03
```

### DevOps Easy Learning tags
```
git tag -a v1.0.0 -m "DevOps Easy Learning Website release v1.0.0"
git tag
git push -u origin v1.0.0
```

```
git tag -a v1.1.0 -m "DevOps Easy Learning Website release v1.1.0"
git tag
git push -u origin v1.1.0
```

### DevOps Easy Learning Website Releases

**About:** This is the description of the repository (DevOps Easy Learning Website)

**Release Title:** E-learning release v1.0.0

**Release Description:**

**This is our v1.0.0 release of the DevOps Easy Learning Website. The following changes are included in this release:**
- Sign up/Log in.
- Email.
- Upload and download.
- Payment, home, courses, contact, enroll
- Email and logo
- Course enrolment.
- Space for testimonies.
- Pop up for messages.
- Translation capability (one language to another).

#### -----------------------------------------------------------------------------------------------------

**Release Title:** E-learning release v1.1.0

**Release Description:**

**This is our v1.1.0 release of the DevOps Easy Learning Website. The following changes are included in this release:**
- Dashboard
- Student and admin access
- Zoom integration for the online courses.
- Email reminder about payment and course progress.
- Google maps integration.
- Mobile responsive (website will be fully responsive,)
- Upload and download and course materials
- Able to enroll in the next section when another section is going on.
- Browsers testing




