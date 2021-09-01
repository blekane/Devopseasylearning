## Exception Handling
[Link](https://www.youtube.com/watch?v=91lVdRRl5E4&list=PLhW3qG5bs-L8T6v6DgsZo93DgYDmOF9u4&index=13)

- try-catch
- try-catch-finally
- try-finally

The **finally** block follows a try block or a catch block. A finally block of code always **executes**, irrespective of occurrence of an Exception

**Syntax:**
```groovy
try { 
   //Protected code 
} 
catch(ExceptionType1 e1) { 
   //Catch block 
} 
catch(ExceptionType2 e2) { 
   //Catch block 
} 
catch(ExceptionType3 e3) { 
   //Catch block 
} 
finally {
   //The finally block always executes. 
}
```

**NB:** Exception key word can be used to catch all type of exception
```groovy
try { 
   //Protected code 
} 
catch(Exception e) { 
   //Catch block  
} 
finally {
   //The finally block always executes. 
}
```

### Example 1
**NB:** Exception do not stop the code from running

```groovy
try {
    int i = 1/0
    println('I am inside try block')
}catch (Exception exp) {
    println("I am inside exception block")
    println exp.getCause()
    println exp.getMessage()
}
println("I am inside another block")
```
**OUTPUT:**
```
I am inside exception block
null
/ by zero
I am inside another block
```

### Example 2
```groovy
try {
    int i = 1/0
    println('I am inside try block')
}
catch (ArithmeticException exp1) {
    println("Block to cat Arithmetic exceptions")
}
catch (Exception exp2) {
    println("I am inside exception block")
    println exp2.getCause()
    println exp2.getMessage()
}
finally {
    println("I am inside finally block")
}
println("I am inside another block")
```
**OUTPUT:**
```
Block to cat Arithmetic exceptions
I am inside finally block
I am inside another block
```

### Example 3: try, catch and finally with not exception
```groovy
try {
    int i = 6/3
    println('I am inside try block')
}
catch (ArithmeticException exp1) {
    println("Block to cat Arithmetic exceptions")
}
catch (Exception exp2) {
    println("I am inside exception block")
    println exp2.getCause()
    println exp2.getMessage()
}
finally {
    println("I am inside finally block")
}
println("I am inside another block")
```
**OUTPUT:**
```
I am inside try block
I am inside finally block
I am inside another block
```

### Example 4: try and finally with not exception
```groovy
try {
    int i = 6/3
    println('I am inside try block')
}
finally {
    println("I am inside finally block")
}
println("I am inside another block")
```
**OUTPUT:**
```
I am inside try block
I am inside finally block
I am inside another block
```

### Example 5: try and finally with exception
You will get an errir here because we need to catch the exception

```groovy
try {
    int i = 1/0
    println('I am inside try block')
}
finally {
    println("I am inside finally block")
}
println("I am inside another block")
```

**OUTPUT:**
```
I am inside finally block
Caught: java.lang.ArithmeticException: / by zero
java.lang.ArithmeticException: / by zero
        at script.run(script.groovy:2)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
```

## Jenkins file with try, catch and exception
```groovy
// Every jenkins file should start with either a Declarative or Scripted Pipeline entry point.
node {
    //Utilizing a try block so as to make the code cleaner and send slack notification in case of any error
    try {
        //Call function to send a message to Slack
        notifyBuild('STARTED')
        // Global variable declaration
        def project = 'sa-android'
        def appName = 'Sample App'

        // Stage, is to tell the Jenkins that this is the new process/step that needs to be executed
        stage('Checkout') {
            // Pull the code from the repo
            checkout scm
        }

        stage('Build Image') {
            // Build our docker Image
            sh("docker build -t ${project} .")
        }

        stage('Run application test') {
            // If you need environmental variables in your image. Why not load it attach it to the image, and delete it afterward
            sh("env >> .env")
            sh("docker run --env-file .env --rm ${project} ./gradlew test")
            sh("rm -rf .env")
        }

        stage('Deploy application') {
            // This is the cool part where you deploy. Here, you can specify builds you want to deploy
            switch (env.BRANCH_NAME) {
                case "master":
                    sh("env >> .env")
                    sh("docker run --env-file .env --rm ${project} ./gradlew clean build assembleRelease crashlyticsUploadDistributionRelease")
                    sh("rm -rf .env")
                    break
                case "dev":
                    sh("env >> .env")
                    sh("docker run --env-file .env --rm ${project} ./gradlew clean build assembleDebug crashlyticsUploadDistributionDebug")
                    sh("rm -rf .env")
                    break
            }
        }
    } catch (e) {
        currentBuild.result = "FAILED"
        throw e
      } finally {
        notifyBuild(currentBuild.result)
    }
}

def notifyBuild(String buildStatus = 'STARTED') {
  buildStatus =  buildStatus ?: 'SUCCESSFUL'

  def color = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"
  def details = """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
    <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""

  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFCC00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#228B22'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  slackSend (color: colorCode, message: summary)
}
```