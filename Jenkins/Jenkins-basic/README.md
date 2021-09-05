
## General Terms
**- Agent:** An agent is typically a machine, or container, which connects to a Jenkins master and executes tasks when directed by the master.

**Artifact:** An immutable file generated during a Build or Pipeline run which is archived onto the Jenkins Master for later retrieval by users.

**Build:** Result of a single execution of a Project

**Folder** An organizational container for Pipelines and/or Projects, similar to folders on a file system.

**Job or prject:** A deprecated term, synonymous with Project.

**Jenkins Master:** The central, coordinating process which stores configuration, loads plugins, and renders the various user interfaces for Jenkins.

**Node:** A machine which is part of the Jenkins environment and capable of executing Pipelines or Projects. Both the Master and Agents are considered to be Nodes.

**Project:** A user-configured description of work which Jenkins should perform, such as building a piece of software, etc.

**Pipeline:** A user-defined model of a continuous delivery pipeline

**Plugin:** An extension to Jenkins functionality provided separately from Jenkins or a software that extends the core functinality of Jenkins

**Trigger:** A criteria for triggering a new Pipeline run or Build.

**Step:** A single task; fundamentally steps tell Jenkins what to do inside of a Pipeline or Project

**Workspace:** A disposable directory on the file system of a Node where work can be done by a Pipeline or Project. Workspaces are typically left in place after a Build or Pipeline run completes unless specific Workspace cleanup policies have been put in place on the Jenkins Master.


**Build**: A result got after executing a job or a project.

**Upstream:** A configured Pipeline or Project which triggers a separate Pipeline or Project as part of its
execution.

**Downstream:** A configured Pipeline or Project which is triggered as part of the execution of a separate Pipeline
or Project.


### Jenkins Dashboard:
![](/images/jenkins1.JPG)
1. It a search bar
2. It is the user that is login
3. This bar will show you the paths while navigating within jenkins and also help me going back easily.
4. New Item: It is use to create a new job
5. People: This is used for user management in Jenhkins and it shows the list of users that are set up in Jenkins.
6. Build History: This shows us the history of build that has happens in jenkins. This include the build on both the master and the slaves node.
7. Manage Jenkins: This is the most important menu item used to configure and administer Jenkins.
8. My Views: This is use to view a view that you created
9. New View: this is to create a new view to organize your jobs
10. Build Queue: This will keep the list of job that are waiting to be executed by jenkins. By default, Jenking executors is set to 2, which means jenkins can only run 2 jobs in parallel. This means if you run more that 2 jobs in jenkins with the default settings, other job will wait in the **Build Queue**. Some company like to set it the executors at **10** per nodes or slave which means jenkins can run 10 jobs in prallel on master, nodes or slaves.
11. Build Executor Status: This shows us the default number of exectors which is set to 2 which means jenkins can only run 2 jobs in parallel on master, slaves or noides.
12. This is the jenkins version
13. Add description: this is used to add a message on the dashboard that any user will see when they log in in to Jenkins.

### How to enable Markup Formatter
This is usefull if we want html instead of plain test
![](/images/jenkins11.JPG)

### Manage Jenkins
![](/images/jenkins20.JPG)
1. This is used for global settings like Environment variables, slack nofication, email notification, SonarQube configuration on so on
2. This is used to configure tools like Maven, git, Gradle, JDK. or to configure path.
3. This is used the upload, install and remove plugins
4. This is used to add remove jenkins slaves or nodes
5. This is used to manage security in Jenkins
6. This is used to add and remove credentials
7. 
8. This is used to assign permission to users on the job folders on the dashboard
9. This shows us all the system informations and all the plugins installed
10. This is jenkins logs message. This is usefull for troubleshooting purpose
11. This shows us Number of online executors, Number of busy executors, Number of available executors, Queue length or the number of executors that are waiting and the time in the Queue
12. This shows all information about Jenkins and the 3rd party libraries
13. 
14. Discard all the loaded data in memory and reload everything from file system. Useful when you modified config files directly on disk. An example here is to a job config xml for a job to create another job on the disk
15. This is for Jenkins CLI
16. This is a groovy console used to execude groovy scripts
17. This Stops executing new builds, so that the system can be eventually shut down safely. 


### Configure system
![](/images/jenkins18.JPG)

1. It a jenkins home or where jenkins is installed
2. It is used to display a message on the dashboard. All users will see this message when there are login.
3. This is the max number of jobs that jenkins can run in parallel on master or slaves. It 2 by default.
4. It used to select which nodes or slaves jenkins should used to run the job
5. this is the number of second that Jenkins should before starting a new job. The default is `5` seconds
6. This is max number of retry when Jenkins is not able the checkout the code from VCS. if we specify `5`, Jenkins will try 5 times before failling the job. `0` means jenkins will failed the job immidially whithout any retry.

![](/images/jenkins19.JPG)

7. This is used to choose the default view that will be display on the dashboard. The default is `all`
8. We can restrict a project nameming convention. In this case, all jobs must start with `Dev`
9. This is jenkins URL


### Job configurations


### What is the difference between Poll SCM & build periodically in Jenkins?
Poll SCM periodically check whether changes were made (i.e. new commits) and builds the project if new commits where pushed since the last build, whereas build periodically builds the project periodically even if nothing has changed.

### What is the difference between Poll SCM & build periodically in Jenkins and GitHub hook trigger for GITScm polling?

1. **GitHub hook trigger for GITScm polling:** The code will be trigger only if developers pushed the code into VCS or there is a new commit.

2. **Poll SCM**: Poll SCM periodically check whether changes were made (i.e. new commits) and builds the project if new commits where pushed since the last build. If new commits where not pushed since the last build, Jenkins will not pull the code.

**NB:** This is not good optiion because of memory consumption. This is because Jenkins will be checking the repository every time to find out if new commits where pushed. If the time is 5 minutes for instance, Jenkins will ckecking this repository every 5 minutes

3. **Build periodically**: This build periodically builds the project periodically even if nothing has changed or no new commits where pushed since the last build. If the time is 5 minutes for instance, Jenkins will pull the code every 5 minutes and build it even if nothing has changed or no new commits where pushed since the last build. 

**NB:** This will save us memory comsumption because Jenkins is not watching that repository every 5 minutes. **This is good to schedule a backup**.
 
- 0 6 * * *: This will create a backup every 6:00 AM in the morning.
