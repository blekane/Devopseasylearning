### How to get all the plugins install in jenkins
* add script at the end of jenkins url, hit enter and paste the code below

https://[Jenkins url]/script

http://10.0.0.36:8080/script

```sh
def pluginList = new ArrayList(Jenkins.instance.pluginManager.plugins)
pluginList.sort { it.getShortName() }.each{
  plugin -> 
    println ("${plugin.getShortName()}: ${plugin.getVersion()}")
}
```

**Role-based Authorization Strategy:** Enables user authorization using a Role-Based strategy. Roles can be defined globally or for 

**configuration-as-code:** This plugin allows configuration of Jenkins based on human-readable declarative configuration files.

**Slack Notification:** Integrates Jenkins with Slack, allows publishing build statuses, messages and files to Slack channels.

**Build Pipeline:** This plugin renders upstream and downstream connected jobs that typically form a build pipeline. In addition, it offers the ability to define manual triggers for jobs that require intervention prior to execution, e.g. an approval process outside of Jenkins.

**Config AutoRefresh:** The Config AutoRefresh Plugin provides a way to configure the auto-refresh rate from the Jenkins UI.

**Email Extension Plugin:**  This plugin lets you configure every aspect of email notifications. You can customize things such as when to send the email, who receives it, and what the email says.

**CloudBees Docker Build and Publish plugin:** This plugin enables building Dockerfile based projects, as well as publishing of the built images/repos to the docker registry.

**Docker Pipeline:** Build and use Docker containers from pipelines.

**GitHub Integration Plugin:** GitHub Integration Plugin for Jenkins

**Multibranch Scan Webhook Trigger:** Trigger that can receive any HTTP request and trigger a multibranch job scan when token matched.