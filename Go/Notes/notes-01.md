
## Go Programming Language
- Website [here](https://www.golangprograms.com/go-language.html)


## Installing Go, an IDE
Install go [here](https://golang.org/dl/)

## Vs code config
- install go language plugin or vs code
- type `ctrl + shift + p` on window or `command + shift + p` on Mac and seach for `Go:Install/Update Tools`. Select it and check all the check bosses and save
- Restart VS code

## How to Install Go on Ubuntu 20.04 [here]https://linuxize.com/post/how-to-install-go-on-ubuntu-20-04/
```
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
vim ~/.profile
source ~/.profile
go version

OR

sudo snap install go --classic
go version
```

### Test
```go
package main

import "fmt"

func main() {
	fmt.Printf("Hello, World\n")
}
```

## Variables & Functions
```go
package main

import "fmt" //this mean something will be using the fmt (format)

func main() {
	fmt.Println("Hello, world.")

	var whatToSay string
	var i int

	whatToSay = "Goodbye, cruel world"
	fmt.Println(whatToSay)

	i = 7

	fmt.Println("i is set to", i)

	whatWasSaid, theOtherThingThatWasSaid := saySomething()

	fmt.Println("The function returned", whatWasSaid, theOtherThingThatWasSaid)

}

func saySomething() (string, string) {
	return "something", "else"
}

//-------------------------------------------------
package main

import "log"

var s = "seven"

func main() {
	var s2 = "six"
	log.Println(s2)
	log.Println(s)

}

//-------------------------------------------------
package main

import (
	"log"
	"time"
)

type User struct {
	FirstName   string
	LastName    string
	PhoneNumber string
	Age         int
	BirthDate   time.Time
}

func main() {
	user := User{
		FirstName:   "Trevor",
		LastName:    "Sawler",
		PhoneNumber: "1 555 555 1212",
	}

	log.Println(user.FirstName, user.LastName, "Birthdate:", user.BirthDate, "the user phone number is:", user.PhoneNumber)
}

//-------------------------------------------------
package main

import (
	"log"
	"time"
)

type User struct {
	FirstName   string
	LastName    string
	PhoneNumber string
	Age         int
	BirthDate   time.Time
}

func main() {
	user := User{
		FirstName:   "Trevor",
		LastName:    "Sawler",
		PhoneNumber: "1 555 555 1212",
	}

	log.Println("\nThe use first name is:", user.FirstName, "\nThe last name is:", user.LastName, "\nBirthdate:", user.BirthDate, "\nThe user phone number is:", user.PhoneNumber)
}

//-------------------------------------------------
// variables definition
package main

import "log"

func main() {
	var s1 string
	var s2 int

	s1 = "Hi"
	s2 = 11

	s3 := "another string"

	var s4 string = "Hello"
	var s5 int = 10
	var s6 float32 = 2.54
	s7 := 20

	log.Println(s1, s2, s3, s4, s5, s6, s7)
	log.Println("S1 is", s1, "and S2 is egaul to:", s2)

}
```

## Data type
```go
// maps
package main

func main() {
	myMap := make(map[string]string) //string map definition

	myMap["dog"] = "Samson"
	myMap["city"] = "TX"
	myMap["Country"] = "USA"

	println(myMap["dog"])
	println(myMap["city"])
	println(myMap["Country"])
}

//-------------------------------------------------
package main

func main() {
	myMap := make(map[string]int) //int map definition

	myMap["dog"] = 1
	myMap["city"] = 2
	myMap["Country"] = 3

	println(myMap["dog"])
	println(myMap["city"])
	println(myMap["Country"])
}

//-------------------------------------------------
package main

import (
	"log"
)

type User struct {
	FirstName string
	LastName  string
}

func main() {
	myMap := make(map[string]User)

	me := User{
		FirstName: "Trevor",
		LastName:  "Sawler",
	}

	myMap["me"] = me

	log.Println(myMap["me"].FirstName)
	log.Println(myMap["me"].LastName)

}

//-------------------------------------------------
package main

import (
	"log"
	"sort"
)

func main() {
	// slices
	var mySlice []int

	mySlice = append(mySlice, 2)
	mySlice = append(mySlice, 1)
	mySlice = append(mySlice, 3)

	var mySlice2 []string

	mySlice2 = append(mySlice2, "Tom")
	mySlice2 = append(mySlice2, "Paul")
	mySlice2 = append(mySlice2, "Smith")

	sort.Ints(mySlice)
	log.Println(mySlice)
	log.Println(mySlice2)

}

//-------------------------------------------------
package main

import "fmt"

var (
	product  = "Mobile"
	quantity = 50
	price    = 50.50
	inStock  = true
)

func main() {
	fmt.Println(quantity)
	fmt.Println(price)
	fmt.Println(product)
	fmt.Println(inStock)
}



package main

import (
	"log"
	"sort"
)

type User struct {
	FirstName string
	LastName  string
}

//-------------------------------------------------
func main() {
	myMap := make(map[string]User)

	me := User{
		FirstName: "Trevor",
		LastName:  "Sawler",
	}

	myMap["me"] = me

	log.Println(myMap["me"].FirstName)

	// slices
	var mySlice []int

	mySlice = append(mySlice, 2)
	mySlice = append(mySlice, 1)
	mySlice = append(mySlice, 3)

	sort.Ints(mySlice)

	log.Println(mySlice)

	// shorthand for slices

	numbers := []int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
	log.Println(numbers)

	// print first two elements of slice, starting at first position
	log.Println(numbers[0:2])

	// create a slice of strings
	names := []string{"one", "seven", "fish", "cat"}
	log.Println(names)
	log.Println(names[0])
	log.Println(names[1])
}
```

## Decision Structures
```go
package main

import "log"

func main() {
	// the if statement
	var isTrue bool

	isTrue = false

	if isTrue == true {
		log.Println("isTrue is", isTrue)
	} else {
		log.Println("isTrue is", isTrue)
	}

	cat := "cat2"

	if cat == "cat" {
		log.Println("Cat is cat")
	} else {
		log.Println("Cat is not cat")
	}

	myNum := 100
	isTrue = false

	if myNum > 99 && !isTrue {
		log.Println("myNum is greater than 99 and isTrue is set to true")
	} else if myNum < 100 && isTrue {
		// do something
	} else if myNum == 101 || isTrue {
		// do something
	} else if myNum > 1000 && isTrue {
		// do something
	}

	// the switch statement

	myVar := "cat"

	switch myVar {
	case "cat":
		log.Println("myVar is set to cat")

	case "dog":
		log.Println("myVar is set to dog")

	case "horse":
		log.Println("myVar is set to horse")

	case "fish":
		log.Println("myVar is set to fish")

	default:
		log.Println("myVar is something else")
	}
}

//-------------------------------------------------
func main() {
	// the switch statement

	myVar := "cat"

	switch myVar {
	case "cat":
		log.Println("myVar is set to cat")

	case "dog":
		log.Println("myVar is set to dog")

	case "horse":
		log.Println("myVar is set to horse")

	case "fish":
		log.Println("myVar is set to fish")

	default:
		log.Println("myVar is something else")
	}
}

//-------------------------------------------------
package main

import "fmt"

func main() {

	if 7%2 == 0 {
		fmt.Println("7 is even")
	} else {
		fmt.Println("7 is odd")
	}

	if 8%4 == 0 {
		fmt.Println("8 is divisible by 4")
	}

	if num := 9; num < 0 {
		fmt.Println(num, "is negative")
	} else if num < 10 {
		fmt.Println(num, "has 1 digit")
	} else {
		fmt.Println(num, "has multiple digits")
	}
}
//-------------------------------------------------
```

## loops
```go
package main

import "log"

func main() {
	type User struct {
		FirstName string
		LastName  string
		Email     string
		Age       int
	}

	var users []User
	users = append(users, User{"John", "Smith", "john@smith.com", 30})
	users = append(users, User{"Mary", "Jones", "mary@jones.com", 20})
	users = append(users, User{"Sally", "Brown", "sally@smith.com", 45})
	users = append(users, User{"Alex", "Anderson", "alex@smith.com", 17})

	for _, l := range users {
		log.Println(l.FirstName, l.LastName, l.Email, l.Age)
	}
}



