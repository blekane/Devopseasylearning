##  Data Types for Variables

### Overview of Type Constraints
* The type argument in a variable block allows you to restrict the type of value that will be accepted as the value for a variable.
* Only variable that have a value of type string will be accepted and any other value will not be accepted.
* if you do not defined the type, any value will be accepted.

```tf
variable "image_id" {
type = string
}
```
 ### Data type in terraform
 * String
```tf
variable "instance_id"{
type = string
instance_id = "ami-082b5a644766e0e6f"
}
```

* list
```tf
variable "region" {
type = list
region = ["usa", "Singapore", "Mumba"]
}
```

* Number
```tf
variable "id" {
type = list
id = 258
}
```

* Map
```tf
variable "map_value" {
type = list
map_value = {name="Mabel", age=52}
}
```