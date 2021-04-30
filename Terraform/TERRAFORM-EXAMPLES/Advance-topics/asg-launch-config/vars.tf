variable "tags" {
  type = map(string)
  default     = {}
}

variable "_tag_defaults" {
  description = "Default tags to add to all resources"
  type        = map(string)
  default = {
    terraform = "yes"
    owner         = "tom.nadeau@tcs.com" 
    project       = "mam" 
    environment   = "dev" 
    application   = "mam-dev" 
    t_dcl         = "2" 
    t_cost_centre = "9516.9130." 
    t_environment = "DEV"
    t_AppID       = "SVC02524232"
    terraform     =  "tree"
  }
}

variable "webapp" {
  description = "The map of EC2 properties for webapp to override defaults"
  type        = map(string)
  default     = {}
}

variable "_webapp_defaults" {
  description = "Default WebApp properties, if not overridden"
  type        = map(string)
  default = {
    instance_count = "1"
    instance_start = true # Will set the ASG to the instance_count if true and 0 if false
    instance_type  = "t2-micro"
    key_name       = "jenkins-key"
    root_disk_size = "10"
    port           = "8080"
  }
}


