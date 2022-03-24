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

### Getting Started
- [Get started with Datadog](https://app.datadoghq.com/signup) or [here](https://docs.datadoghq.com/getting_started/)

- [Login](https://app.datadoghq.com/account/login?redirect=f)
- Datadog free trial is only for 5 hosts

### Basic Agent Usage [HERE](https://docs.datadoghq.com/agent/basic_agent_usage/osx/?tab=agentv6v7)
```
datadog-agent --help
datadog-agent version
datadog-agent config
datadog-agent stop
datadog-agent status
```

### Metrics and Host Monitor [here](https://docs.datadoghq.com/monitors/create/types/host/?tab=checkalert)
```
CPU load is very high on {{host.name}} @slack-pipeline-test

The CPU load on {{host.name}}({{host.ip}}) is {{value}}, which is above the set limits @slack-team

The host {{host.name}}({{host.ip}}) is down
Host {{host.name}} is down. Please investigate now and take action @slack-pipeline-test
```

### Datadog pricing
Plans to fit your scale [here](https://www.datadoghq.com/pricing/)

### Datadog start and stop
```
systemctl status datadog-agent
systemctl start datadog-agent
systemctl stop datadog-agent
systemctl restart datadog-agent
```

## Start Datadog
docker run -d --name dd-agent -v /var/run/docker.sock:/var/run/docker.sock:ro -v /proc/:/host/proc/:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro -e DD_API_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxx -e DD_SITE="datadoghq.com" gcr.io/datadoghq/agent:7


### Datadog config file and integrations
1. agent configuration file
```
cd /etc/datadog-agent/
ls /etc/datadog-agent/conf.d
```

2. Integrations
```
cat /etc/datadog-agent/datadog.yaml
```

### All check enable in the config file. Below check are enable by default
```
datadog-agent configcheck
```

```s
root@ip-172-31-12-205:~# datadog-agent configcheck
=== cpu check ===
Configuration provider: file
Configuration source: file:/etc/datadog-agent/conf.d/cpu.d/conf.yaml.default
Instance ID: cpu:d884b5186b651429
{}
~
===
=== disk check ===
Configuration provider: file
Configuration source: file:/etc/datadog-agent/conf.d/disk.d/conf.yaml.default
Instance ID: disk:e5dffb8bef24336f
use_mount: false
~
===
=== file_handle check ===
Configuration provider: file
Configuration source: file:/etc/datadog-agent/conf.d/file_handle.d/conf.yaml.default
Instance ID: file_handle:d884b5186b651429
{}
~
===
=== io check ===
Configuration provider: file
Configuration source: file:/etc/datadog-agent/conf.d/io.d/conf.yaml.default
Instance ID: io:d884b5186b651429
{}
~
===
=== load check ===
Configuration provider: file
Configuration source: file:/etc/datadog-agent/conf.d/load.d/conf.yaml.default
Instance ID: load:d884b5186b651429
{}
~
===
=== memory check ===
Configuration provider: file
Configuration source: file:/etc/datadog-agent/conf.d/memory.d/conf.yaml.default
Instance ID: memory:d884b5186b651429
{}
~
===
=== network check ===
Configuration provider: file
Configuration source: file:/etc/datadog-agent/conf.d/network.d/conf.yaml.default
Instance ID: network:d884b5186b651429
{}
~
===
=== ntp check ===
Configuration provider: file
Configuration source: file:/etc/datadog-agent/conf.d/ntp.d/conf.yaml.default
Instance ID: ntp:d884b5186b651429
{}
~
===
=== uptime check ===
Configuration provider: file
Configuration source: file:/etc/datadog-agent/conf.d/uptime.d/conf.yaml.default
Instance ID: uptime:d884b5186b651429
{}
~
===
```

### Some datadog commands
```
$ D_AGENT_MAJOR_VERSION=7 DD_API_KEY=235e1f4c8617fb97badsadaddc36 DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

$ systemctl start datadog-agent
$ systemctl stop datadog-agent
$ systemctl restart datadog-agent
$ systemctl status datadog-agent

$ ls /var/log/datadog/
$ more /etc/datadog-agent/datadog.yaml
$ more /var/log/datadog/agent.log
$ more /var/log/datadog/process-agent.log
$ more /var/log/datadog/trace-agent.log
$ datadog-agent configcheck
$ datadog-agent config
$ datadog-agent health
$ datadog-agent hostname
$ datadog-agent version
```


### Create a stress
```
docker run -d --rm progrium/stress -c 8 -t 100s
```