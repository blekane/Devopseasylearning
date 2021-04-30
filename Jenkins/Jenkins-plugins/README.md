### How to get all the plugins install in jenkins
* add script at the end of jenkins url, hit enter and paste the code below

https://jenkins2.nonprod.nafta.dcp.aws.mbusa.com/script

```sh
def pluginList = new ArrayList(Jenkins.instance.pluginManager.plugins)
pluginList.sort { it.getShortName() }.each{
  plugin -> 
    println ("${plugin.getShortName()}: ${plugin.getVersion()}")
}
```


Role-based Authorization Strategy: role-strategy
Matrix Authorization Strategy Plugin: matrix-auth

