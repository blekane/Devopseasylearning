### What is Dadatog
Datadog is a data observability service for cloud-scale applications, providing monitoring of servers, databases, tools, and services, through a SaaS-based data analytics platform.

###  DataDog Architecture
**Agent:** The agents are installed on the nodes and the report the information to datadog

**Datadog:** it process the information that is coming from nodes, create dashboard and send notification to you alerting system like slack, email and so on when things goes wrong

![](/images/datadog2.JPG)

###  Agent Architecture

Collector: gather metrics from nodes or servers or gather all the servers information.

**DogstatsD:** collection information from your application

**SupervisorD:** this is like a manager that keeps everything up and running.

**Forwarder:** it send the information that it collects from servers or nodes to datadog in the cloud which create dashboard and send alerts out.

![](/images/datadog1.JPG)


### Basic Agent Usage
[Basic Agent Usage for CentOS](https://docs.datadoghq.com/agent/basic_agent_usage/centos/?tab=agentv6v7)

