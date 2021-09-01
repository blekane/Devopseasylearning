## How to install Groovy on Ubuntu 20.04
[Link to install groovy](https://sharadchhetri.com/how-to-install-groovy-on-ubuntu-20-04-lts/)
```
sudo snap install groovy --classic
```
```
vi ~/.bashrc
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
export PATH=$JAVA_HOME/bin:$PATH
```
```
source ~/.bashrc
```

To open Groovy Console, go to `Activities` and in search type `Groovy`. Click `Console For Ap…` icon. It will open the Groovy Console.

## How to set up groovy in vs code in ubuntu?
[How to run groovy on Visual Studio Code](https://www.youtube.com/watch?v=bh2zQkJFPmE&t=365s)
- Step 0 : Install vs code with `sudo snap install code --classic`
- Step 1 : Open VS Code and go to extensions and install `code-groovy`
- Step 2 : Create a folder and create a file with `.groovy` extenstion
- Step 3 : Write groovy code in the file
- Step 4 : Run groovy code with `groovy ./[script name].groovy`
```
groovy ./script.groovy
```
- Step 5 : Write groovy code in the file
- Step 6 : Open VS Code and go to extensions and install `run code` to run the code in vs code directly

## Print some test
NB: We do not to put the code on the class. We can just write and it will works perfectly.
```groovy
println("Hello World");
println("This is to test groovy");
```

## Test code in the class
```groovy
class MyFirstGroovyProgram {
    static void main(args) {
        println("Hello World");
        println("This is to test groovy");
    }
}
```










