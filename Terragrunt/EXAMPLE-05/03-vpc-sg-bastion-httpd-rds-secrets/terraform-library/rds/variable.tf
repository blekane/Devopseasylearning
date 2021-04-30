variable "environment" {
  type    = string
  default = "man-prod"
}

variable "identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "storage_type" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "name" {
  type = string
}

variable "port" {
  type = number
}
