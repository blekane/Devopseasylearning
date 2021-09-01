## Variables
```groovy
class MyFirstGroovyProgram {
    static void main(args) {
        println("Hello World");
        def name = "Dog";
        def age = 45;

        println(age);
        println(name);
        println("$name and $age");
    }
}
```
**OUTPUT:**
```
Hello World
45
Dog
Dog and 45
```

## Variable concatenation
- A string surrounded by single quotes is taken literally
- But backslashed characters are recognized
```groovy
class MyFirstGroovyProgram {
    static void main(args) {
        def name = "Derek";
        def age = 40 
        println(name)
        println(age)
        println('I am $name and I am $age year old\n');
        println("I am $name and I am $age year old\n");
        println("I am ${name} and I am ${age} year old\n");
    }
}
```
**OUTPUT:**
```
Derek
40
I am $name and I am $age year old
I am Derek and I am 40 year old
I am Derek and I am 40 year old
```

## Variables in the list
```groovy
def (a,b,c) = [30,40,50]
println a
println b
println c
println (a)
println (b)
println (c)
println("a is ${a}, b is ${b} and c is ${c}")
```
**OUTPUT:**
```
30
40
50
30
40
50
a is 30, b is 40 and c is 50
```

## Variables in the list with type
```groovy
def (String a, int b, String c) = ['Tom', 40, 'Hello']
println a
println b
println c
println (a)
println (b)
println (c)
println("a is ${a}, b is ${b}, c is ${c}")
```

**OUTPUT:**
```
Tom
40
Hello
Tom
40
Hello
a is Tom, b is 40, c is Hello
```

```groovy
def (a, b, c) = ['Tom', 40, 'Hello']
println("a is ${a}, b is ${b}, c is ${c}")
```

**OUTPUT:**
```
a is Tom, b is 40, c is Hello
```

```groovy
def String a = 'Tom'
def int b = 40
def String c = 'Hello'
println("a is ${a}, b is ${b}, c is ${c}")
```

**OUTPUT:**
```
a is Tom, b is 40, c is Hello
```

```groovy
String a = 'Tom'
int b = 40
String c = 'Hello'
println("a is ${a}, b is ${b}, c is ${c}")
```

**OUTPUT:**
```
a is Tom, b is 40, c is Hello
```