## The Go Playground
LINK [HERE](https://play.golang.org/)

## helloworld
```go
package main

import (
	"fmt"
)

func main() {
	fmt.Println("Hello, playground")
}
```

## Init go dir
```
go mod init github.com/pluralsight/webservice
```

## Variables declaration
```go
package main

import (
	"fmt"
)

func main() {
	var i int
	i = 42
	fmt.Println(i)

	var f float32 = 3.14
	fmt.Println(f)

	firstName := "Arthur"
	fmt.Println(firstName)

	x := 5
	fmt.Println(x)

	y := 5.25
	fmt.Println(y)
	
	d := true
	fmt.Println(d)

	c := complex(3, 4)
	fmt.Println(c)

	a, b := real(c), imag(c)
	fmt.Println(a, b)
}
```

## Arrays
```go
package main

import "fmt"

func main() {
	var arr [4]int //size of the array or the number of element in the array
	arr[0] = 1
	arr[1] = 2
	arr[2] = 3
	arr[3] = 10
	fmt.Println(arr)
	fmt.Println(arr[1])

	arr2 := [4]int{1, 2, 3, 20}
	fmt.Println(arr2)
	fmt.Println(arr2[3])
}
```

## Slices
```go
package main

import "fmt"

func main() {
	slice := []int{1, 2, 3}

	fmt.Println(slice)
	fmt.Println(slice[0])
	fmt.Println(slice[1])
	fmt.Println(slice[2])

	slice = append(slice, 50)
	slice = append(slice, 10, 25, 1, 58, 548)
	fmt.Println(slice)
}
```

## Map
```go
package main

import "fmt"

func main() {

	m := map[string]int{"foo": 42, "car": 20}

	fmt.Println(m)
	fmt.Println(m["foo"])

	m["bar"] = 27
	fmt.Println(m)
	delete(m, "bar")
	fmt.Println(m)
}
```

## Struct
```go
package main

import "fmt"

func main() {

	type user struct {
		ID        int
		FirstName string
		LastName  string
	}
	u := user{
		ID:        1,
		FirstName: "Arthur",
		LastName:  "Dent",
	}
	fmt.Println(u)
	fmt.Println(u.FirstName)
	fmt.Println(u.LastName)
	fmt.Println(u.ID)
	fmt.Println("The user ID is", u.ID, "First Name is", u.FirstName, "and the Last Name", u.LastName)

	u2 := user{ID: 1, FirstName: "Arthur", LastName: "Dent"}
	fmt.Println(u2)
	fmt.Println(u2.FirstName)
	fmt.Println(u2.LastName)
	fmt.Println(u2.ID)
	fmt.Println("The user ID is", u2.ID, "First Name is", u2.FirstName, "and the Last Name", u2.LastName)
}


package main

import "fmt"

func main() {

	type user struct {
		ID        int
		FirstName string
		LastName  string
	}
	u := user{
		ID:        1,
		FirstName: "Arthur",
		LastName:  "Dent",
	}
	fmt.Println(u)
	fmt.Println(u.FirstName)
	fmt.Println(u.LastName)
	fmt.Println(u.ID)
	
	fmt.Println("The user ID is", u.ID, 
		"First Name is", u.FirstName, 
		"and the Last Name", u.LastName,
	)

}



package main

import "fmt"

func main() {

	type user struct {
		ID        int
		FirstName string
		LastName  string
	}
	u2 := user{ID: 1, FirstName: "Arthur", LastName: "Dent"}
	fmt.Println(u2)
	fmt.Println(u2.FirstName)
	fmt.Println(u2.LastName)
	fmt.Println(u2.ID)
	fmt.Println("The user ID is", u2.ID, "First Name is", u2.FirstName, "and the Last Name", u2.LastName)
}


package main

import "fmt"

func main() {

	type user struct {
		ID        int
		FirstName string
		LastName  string
	}
	u2 := user{ID: 1, 
		FirstName: "Arthur", 
		LastName: "Dent",
	}
	
	fmt.Println(u2)
	fmt.Println(u2.FirstName)
	fmt.Println(u2.LastName)
	fmt.Println(u2.ID)
	
	fmt.Println("The user ID is", 
		u2.ID, "First Name is",
		u2.FirstName, 
		"and the Last Name", u2.LastName,
		)
}
```

## Function
The function can be call only in the `main()` function
```go
package main

import (
	"fmt"
)

func main() {
	fmt.Println("Hello, playground")
	startWebServer()
	hello()
}

func startWebServer() {
	println("Starting server...")
	println("Server started")
	
	x := 5
	fmt.Println(x)
	
	var1 := "This is Tom"
	fmt.Println(var1)
}

func hello() {
	println("Hello World...")
	println("This is a test function")
	
}
```

## Function with parameters
```go
package main

import (
	"fmt"
)

func main() {
	fmt.Println("Hello, playground")
	port := 3000
	startWebServer(port)
}

func startWebServer(port int) {
	println("Starting server...")
	println("Server started on port", port)
	
}


package main

import (
	"fmt"
)

func main() {
	fmt.Println("Hello, playground")
	port := 3000
	ssh := 22
	startWebServer(port, 2, 8080, ssh)
}

func startWebServer(port int, numberOfRetries int, listeningPort int, ssh int) {
	println("Starting server...")
	println("Server started on port", port)
	fmt.Println("Number of retries", numberOfRetries)
	fmt.Println("The server is listening on port", listeningPort)
	fmt.Println("The ssh port is", ssh)
}



func main() {
	fmt.Println("Hello, playground")
	port1 := 3000
	port2 := 8080
	ssh := 22
	retries := 22
	gui := "Graphical"
	startWebServer(port1, retries, port2, ssh, gui)
}

func startWebServer(port int, numberOfRetries int, listeningPort int, ssh int, mode string, ) {
	println("Starting server...")
	println("Server started on port", port)
	fmt.Println("Number of retries", numberOfRetries)
	fmt.Println("The server is listening on port", listeningPort)
	fmt.Println("The ssh port is", ssh)
	fmt.Println("The defualt mode is", mode)
	fmt.Println("The defualt mode is", mode)
}

// Result
Starting server...
Server started on port 3000
Number of retries 22
The server is listening on port 8080
The ssh port is 22
The defualt mode is Graphical
```

## Return Function 

```go
package main

import "fmt"

func main() {
	port := 3000
	isStarted := startWebServer(port)
	fmt.Println(isStarted)
}

func startWebServer(port int) bool {
	fmt.Println("Starting server...")
	fmt.Println("Server started on port", port)
	return true
}


package main

import "fmt"

func main() {
	port := 3000
	err := startWebServer(port)
	fmt.Println(err)
}

func startWebServer(port int) error {
	fmt.Println("Starting server...")
	fmt.Println("Server started on port", port)
	return nil
}



package main

import "fmt"
import "errors"

func main() {
	port := 3000
	err := startWebServer(port)
	fmt.Println(err)
}

func startWebServer(port int) error {
	fmt.Println("Starting server...")
	fmt.Println("Server started on port", port)
	return errors.New("Something went wrong")
}
```

## LOOPS

1. loop till condition
```go
package main

func main() {
	var i int
	for i < 5 {
		println(i)
		i++

	}
}


package main

func main() {
	var i int
	for i < 5 {
		println(i)
		i++
		if i == 3 {
			break
		}
		

	}
}



package main

func main() {
	for i := 1; i < 5; i++ {
		println(i)
	}
}


package main

func main() {
	var i int
	for i < 5 {
		println(i)
		i++
		if i == 3 {
			break
		}
	}
}



package main

func main() {
	slice := []int{1, 2, 3}
	for i, v := range slice {
		println(i, v)
	}

	wellKnownPorts := map[string]int{"http": 80, "https": 443}
	for k, v := range wellKnownPorts {
		println(k, v)
	}
}


package main

func main() {

	wellKnownPorts := map[string]int{"http": 80, "https": 443}
	for k, v := range wellKnownPorts {
		println(k, v)
	}
}


package main

func main() {

	wellKnownPorts := map[string]int{"http": 80, "https": 443}
	for k := range wellKnownPorts {
		println(k)
	}
}
```

## Condition
```go
package main

type User struct {
	ID        int
	FirstName string
	LastName  string
}

func main() {
	u1 := User{
		ID:        1,
		FirstName: "Arthur",
		LastName:  "Dent",
	}
	u2 := User{
		ID:        2,
		FirstName: "Ford",
		LastName:  "Prefect",
	}
	if u1 == u2 {
		println("Same user!")
	} else if u1.FirstName == u2.FirstName {
		println("Similar user.")
	} else {
		println("Different user!")
	}
}
```

## switch statement
```go
package main

type HTTPRequest struct {
	Method string
}

func main() {
	r := HTTPRequest{Method: "default"}

	switch r.Method {
	case "GET":
		println("Get request")
	case "DELETE":
		println("Delete request")
	case "POST":
		println("Post request")
	case "PUT":
		println("Put request")
	default:
		println("Unhandled method")
	}
}


package main

type HTTPRequest struct {
	Method string
}

func main() {
	r := HTTPRequest{Method: "DELETE"}

	switch r.Method {
	case "GET":
		println("Get request")
	case "DELETE":
		println("Delete request")
	case "POST":
		println("Post request")
	case "PUT":
		println("Put request")
	default:
		println("Unhandled method")
	}
}


package main

type HTTPRequest struct {
	Method string
}

func main() {
	r := HTTPRequest{Method: "dfrfgghfr"}

	switch r.Method {
	case "GET":
		println("Get request")
	case "DELETE":
		println("Delete request")
	case "POST":
		println("Post request")
	case "PUT":
		println("Put request")
	default:
		println("Unhandled method")
	}
}
```



## Working with pointer
```go
package main

import (
	"fmt"
)

func main() {
	var firstName *string = new(string) //declare firstName as a pointer and initialize with the new function

	*firstName = "Arthur" // dereference the pointer
	fmt.Println(*firstName)
}


