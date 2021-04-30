### Variables
- We can put `def` infront of a viriable or we can just write a variable without `def`
```groovy
println("Hello World");
def name = "Dog";
def age1 = 45;
age2 = 40;

println(age1);
println(age2);
println(name);
```

```
Hello World
45
40
Dog
```


### Variable concatenation
- A string surrounded by single quotes is taken literally
- But backslashed characters are recognized

```groovy
def name = "Derek";
println('I am ${name}\n');
println("I am $name\n");
```
I am ${name}

I am Derek
```

