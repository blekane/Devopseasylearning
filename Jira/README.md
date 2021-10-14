## jira
Link [here](https://hub.docker.com/r/cptactionhank/atlassian-jira/)
```
docker run --name jira --detach --publish 8080:8080 --user root -v /root/jira:/var/atlassian/jira --restart unless-stopped cptactionhank/atlassian-jira:latest
```

