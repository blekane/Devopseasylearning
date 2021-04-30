

### Jenkins delete builds older than latest 20 builds for all jobs
- [Jenkins delete builds older than latest 20 builds for all jobs](https://stackoverflow.com/questions/35610053/jenkins-delete-builds-older-than-latest-20-builds-for-all-jobs)


- I am in the process of cleaning up Jenkins (it was setup incorrectly) and I need to delete builds that are older than the latest 20 builds for every job.
- Is there any way to automate this using a script or something?


You can use the Jenkins Script Console to iterate through all jobs, get a list of the N most recent and perform some action on the others.

### Print all the builds that will be deleted first
```groovy
import jenkins.model.Jenkins
import hudson.model.Job

MAX_BUILDS = 20

for (job in Jenkins.instance.items) {
  println job.name

  def recent = job.builds.limit(MAX_BUILDS)

  for (build in job.builds) {
    if (!recent.contains(build)) {
      println "Preparing to delete: " + build
      // build.delete()
    }
  }
}
```

### Print all the builds that will be deleted and delete everything
```groovy
import jenkins.model.Jenkins
import hudson.model.Job

MAX_BUILDS = 20

for (job in Jenkins.instance.items) {
  println job.name

  def recent = job.builds.limit(MAX_BUILDS)

  for (build in job.builds) {
    if (!recent.contains(build)) {
      println "Preparing to delete: " + build
      // build.delete()
    }
  }
}
```

### For Multibranch Pipelines,Use this to delete builds older than the latest 20 build.
```groovy
MAX_BUILDS = 20
Jenkins.instance.getAllItems(Job.class).each { job ->
  println job.name
  def recent = job.builds.limit(MAX_BUILDS)
  for (build in job.builds) {
    if (!recent.contains(build)) {
      println "Preparing to delete: " + build
      //build.delete()
    }
  }
}
```

