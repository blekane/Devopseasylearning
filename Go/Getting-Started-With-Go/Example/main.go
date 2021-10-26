package main

import (
	"fmt"

	"github.com/pluralsight/webservice/models"
)

func main() {
	u := models.User{
		ID:        2,
		FirstName: "Tricia",
		LastName:  "McMillan",
	}
	fmt.Println(u)
	fmt.Println(u.FirstName)
	fmt.Println(u.LastName)
	fmt.Println("The first name is", u.FirstName, "the last name is", u.LastName)
}