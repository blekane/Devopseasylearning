## Relational operators
- **==**: equal
- **!=**: not equal
- **<:** less than
- **<=**: less than or equal
- **>:** greater than
- **>=**: greater than or equal

**Example 1:**
```groovy
def OS = 'Windows'
if (OS == 'Linux') {
    println("True")
}
else {
   println("False") 
}
```

**Example 2:**
```groovy
class ComparisonDemo {

    public static void main(String[] args){
        int value1 = 1;
        int value2 = 2;
        if(value1 == value2)
            println("value1 == value2");
        if(value1 != value2)
            println("value1 != value2");
        if(value1 > value2)
            println("value1 > value2");
        if(value1 < value2)
            println("value1 < value2");
        if(value1 <= value2)
            println("value1 <= value2");
    }
}
```

**OUTPUT**
```
value1 != value2
value1 <  value2
value1 <= value2
```

**Example 3:**
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

## Logical operators
Groovy offers three logical operators for boolean expressions:
- **&&**: logical "and"
- **||**: logical "or"
- **!**: logical "not"

**Example 4:**
```groovy
def num1 = 10
def num2 = 10

if ((num1 > 10) && (num2 < 10)) {
    println("Num1 is the greatest number")
}else if ((num1 == 10) && (num2 == 10)) {
    println("Num1 and Num2 are equal")
}else if ((num1 == 12) || (num2 == 12)) {
    println("True")
}else {
   println("False")
}
```
**OUTPUT**
```
Num1 and Num2 are equal
```

**Example 5:**
```groovy
class ConditionalDemo1 {

    public static void main(String[] args){
        int value1 = 1;
        int value2 = 2;
        if((value1 == 1) && (value2 == 2))
            System.out.println("value1 is 1 AND value2 is 2");
        if((value1 == 1) || (value2 == 1))
            System.out.println("value1 is 1 OR value2 is 1");
    }
}
```
**OUTPUT**
```
value1 is 1 AND value2 is 2
value1 is 1 OR value2 is 1
```

**Example 6:**
```groovy
def ENV1 = 'prod'
def ENV2 = 'stg'
def ENV3 = 'dev'
def ENV4 = 'qa'

if ((ENV1 == 'prod') && (ENV2 == 'stg')) {
    println("prod and stg")
}else if ((ENV3 == 'dev') || (ENV4 == 'qa')) {
    println("dev or qa")
}else if (ENV1 == 'prod') {
    println("prod")
}else {
   println("UNNOUN")
}
```
**OUTPUT**
```
Num1 and Num2 are equal
```
