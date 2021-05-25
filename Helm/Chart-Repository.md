
## Helm Chart repository
[Creating a Helm Chart Repository](https://tech.paulcz.net/blog/creating-a-helm-chart-monorepo-part-1/)

[HELM CHART REPOSITORY and Chartmuseum](https://chartmuseum.com/docs/#helm-chart-repository)

**What will you learn?**
- Create a github repo call `helm_git_repo`  
- Create 2 charts repo call `demo1` and `demo2`
- Update those charts and package
- Add the index file
- Push the charts to github
- Add a local chart from github
- Deploy demo1
- Add demo3, package, update the index file and push to github

### How to packge a helm chart?

**In the current folder**
```
helm package ./[chart folder]/
helm package ./mychart/
```

**In the current with a specify path**
```
helm package [path to the folder]/[chart folder]
helm package /root/mychart/
```

### The index file
The index file is a yaml file called index.yaml. It contains some metadata about the package, including the contents of a chart's Chart.yaml file. A valid chart repository must have an index file. The index file contains information about each chart in the chart repository. 

**Command to add the index file in git repository**
```
helm repo index .
```

**NB:** Always run this command `helm repo index .` each time that you package a new chart so that the index file can be update.

**This is an example of an index file:**
```yml
demo1:
  - apiVersion: v2
    appVersion: 1.16.0
    created: "2021-05-24T03:29:16.847920834-07:00"
    description: A Helm chart for Kubernetes 1
    digest: 85e615d3d0bd747d546a228851fae36c44ac9a91e88de2cbe89e3e6999cc84ff
    name: demo1
    type: application
    urls:
    - demo1-0.1.1.tgz
    version: 0.1.1
  - apiVersion: v2
    appVersion: 1.16.0
    created: "2021-05-24T03:29:16.847439671-07:00"
    description: A Helm chart for Kubernetes
    digest: 7997e14768c88c63169a88a86097d130ae6a2f3e0bcb6f62aa06683fbb4bc7cf
    name: demo1
    type: application
    urls:
    - demo1-0.1.0.tgz
    version: 0.1.0
  demo2:
  - apiVersion: v2
    appVersion: 1.16.0
    created: "2021-05-24T03:29:16.849065708-07:00"
    description: A Helm chart for Kubernetes 2
    digest: a9e3e3654078ebebafd8e43675a51838087378f3a45f50b1d1666e97c17aaa7f
    name: demo2
    type: application
    urls:
    - demo2-0.1.2.tgz
    version: 0.1.2
  - apiVersion: v2
    appVersion: 1.16.0
    created: "2021-05-24T03:29:16.848403649-07:00"
    description: A Helm chart for Kubernetes
    digest: f806cba6aafa538386935d794164ca0b8d30100d57f611b62bc38451e9bcba18
    name: demo2
    type: application
    urls:
    - demo2-0.1.0.tgz
    version: 0.1.0
generated: "2021-05-24T03:29:16.846809064-07:00"
```

### How to add a Repository from Github example 1?
```
helm repo add --username [you username] --password [acccess token] [local repo name] 'https://raw.githubusercontent.com/[you username]/helm_git_repo/[branch name]'

OR 

helm repo add --username [you username] --password [password] [local repo name] 'https://raw.githubusercontent.com/[you username]/helm_git_repo/[branch name]'


helm repo add --username leonardtia1 --password School123@ my-github-helm-repo 'https://raw.githubusercontent.com/muthu4all/helm_git_repo/master'
```

### How to add a Repository from Github example 2?
This will promp you to enter you password
```
helm repo add [local repo name] https://github.com/leonardtia1/helm_git_repo/[branch name]/
helm repo add my-github-helm-repo https://github.com/leonardtia1/helm_git_repo/master/

helm repo add --username ${GIT_USERNAME} --password ${GIT_PASSWORD} my-github-helm-repo https://github.com/leonardtia1/helm_git_repo/master/

helm install --namespace dev1 my-github-helm-repo/demo3 --name demo3 --set nameOverride=demo3 --set  -f demo-values.yaml

# we can create a credential in jenkins call github-credentials and user ${GIT_PASSWORD} and ${GIT_USERNAME} to get the actual values of those credentials

withCredentials([usernamePassword(credentialsId: 'github-credentials', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')])
```

### Install a release from your new local repository that you added from Github
```
helm install --name test --namespace [namespace ] [release name] [local repo name]/[chart folder name] 
helm install --name test --namespace dev1 demo-release my-github-helm-repo/demo1
```
## Local commands

**Search within a local repo:**
```
helm search repo [local repo name]
helm search repo my-github-helm-repo
```

**Update a repo:**
```
helm repo update
```

**Create a new chart and packge:**
```
cd helm_git_repo
helm create demo3
helm package ./demo3/
```

**Update the index file:**
```
helm repo index .
```
**Push changes to github:**
```
git add .
git commit -m "my-repo"
git push -u origin master
```