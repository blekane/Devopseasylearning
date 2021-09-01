## Conditional Statements or Decision Making Statements in Groovy
[Reference Link](http://groovy-lang.org/semantics.html#_conditional_structures)

**We have:**
- if-else
- switch-case
- Control Structures
- Conditional statements
- Looping
- Exception

## if-else
- == 
- <
- >
- <=
- =>
- !=

### Compare numbrs
```groovy
class MyFirstGroovyProgram {
    static void main(args) {
        def num = 11
        if (num == 10) {
            println("The number is 10")
        }
        else {
           println("The number is not 10") 
        }
    }
}
```

```groovy
def num = 11
if (num == 10) {
    println("The number is 10")
}
else {
   println("The number is not 10") 
}
```
```groovy
def num = 11
if (num == 10) 
    println("The number is 10")
else 
   println("The number is not 10") 
```
### if, else if and else
```groovy
def num = 15
if (num == 10) {
    println("The number is equal to 10")
}
else if (num > 10) {
    println("The number is greater than 10")
}
else {
   println("The number is less than 10")
}
```
OR
```groovy
def num = 15
if (num == 10) {
    println("The number is equal to 10")
}else if (num > 10) {
    println("The number is greater than 10")
}else {
   println("The number is less than 10")
}
```

### Compare strings
```groovy
def OS = 'Windows'
if (OS == 'Linux') {
    println("True")
}
else {
   println("False") 
}
```
OR
```groovy
def OS = 'Windows'
if (OS == 'Linux') {
    println("True")
}else {
   println("False") 
}
```

```groovy
def OS = 'Windows'
if (OS == 'Linux') 
    println("True")
else 
   println("False") 
```

## Switch case
Sometimes the nested if-else statement is so common and is used so often that an easier statement was designed called the **switch statement**.

**Syntax:**
```groovy
switch(expression) { 
   case expression #1: 
   statement #1 
   ... 
   case expression #2: 
   statement #2 
   ... 
   case expression #N: 
   statement #N 
   ... 
   default:
   statement #Default 
   ... 
} 
```

**The general working of this statement is as follows** 

- The expression to be evaluated is placed in the switch statement.
- There will be multiple case expressions defined to decide which set of statements should be executed based on the evaluation of the expression.
- A **break** statement is added to each case section of statements at the end. This is to ensure that the loop is exited as soon as the relevant set of statements gets executed.
- There is also a **default case** statement which gets executed if none of the prior case expressions evaluate to true.

```groovy
def OS = 'ubuntu'
switch(OS) {
    case {OS == 'ubuntu'}:
       println('This is Ubuntu OS') 
    break
    case {OS == 'centos'}:
       println('This is CentOs OS') 
    break
    case {OS == 'fedora'}:
       println('This is Fedora OS') 
    break
    case {OS == 'redhat'}:
       println('This is Redhat OS') 
    break
    default:
        println('Invalid OS')
}
```

```groovy
class Example { 
   static void main(String[] args) { 
      //initializing a local variable 
      int a = 2
		
      //Evaluating the expression value 
      switch(a) {            	
         case 1: 
            println("The value of a is One"); 
            break; 
         case 2: 
            println("The value of a is Two"); 
            break; 
         case 3: 
            println("The value of a is Three"); 
            break; 
         case 4: 
            println("The value of a is Four"); 
            break; 
         default: 
            println("The value is unknown"); 
            break; 
      }
   }
}
````

```groovy
def OS = 'ubuntu'
switch(OS) {
    case 'ubuntu':
       println('This is Ubuntu OS') 
    break
    case 'centos':
       println('This is CentOs OS') 
    break
    case 'fedora':
       println('This is Fedora OS') 
    break
    case 'redhat':
       println('This is Redhat OS') 
    break
    default:
        println('Invalid OS')
}
```


```groovy
class SwitchExample {
   static main(args) {
      String str = "Test"
      switch (str) {
         case String: println "${str} is a String"; break;
         case Integer: println "${str} is an Integer"; break;
         default: println "Unknown";
      }
      Integer num = 100
      switch (num) {
         case String: println "${num} is a String"; break;
         case Integer: println "${num} is an Integer"; break;
         default: println "Unknown";
      }
   }
}


```groovy
class SwitchExample {
   static main(args) {
      String str = "Test"
      switch (str) {
         case String: 
            println "${str} is a String"; 
        break;
         case Integer: 
            println "${str} is an Integer"; 
        break;
         default: 
            println "Unknown";
      }
      Integer num = 100
      switch (num) {
         case String: 
            println "${num} is a String"; 
        break;
         case Integer: 
            println "${num} is an Integer"; 
        break;
        default: 
            println "Unknown";
      }
   }
}
```

```groovy
class SwitchExample {
   static main(args) {
      String str = "Test"
      switch (str) {
         case String: 
            println "${str} is a String" 
        break
         case Integer: 
            println "${str} is an Integer" 
        break
         default: 
            println "Unknown"
      }
      Integer num = 100
      switch (num) {
         case String: 
            println "${num} is a String" 
        break
         case Integer: 
            println "${num} is an Integer"
        break
        default: 
            println "Unknown"
      }
   }
}
```


```groovy
def OS = 'ubuntu'
switch(OS) {
    case 'ubuntu':
       sh("ls") 
    break
    case 'centos':
       println('This is CentOs OS') 
    break
    case 'fedora':
       println('This is Fedora OS') 
    break
    case 'redhat':
       println('This is Redhat OS') 
    break
    default:
        println('Invalid OS')
}