provider "aws" {
  region = "us-east-1"
}

module "vpc_basic" {
  //source        = "github.com/turnbullpress/tf_vpc_basic.git?ref=v0.0.1"
  source = "./vpc"
  name          = "web-vpc"
  cidr          = "10.0.0.0/16"
  public_subnet = "10.0.1.0/24"
}


module "vpc_basic01" {
  source = "./web"
  key_name = "jenkins-key"
  region = "us-east-1"
  instance_type = "t2.micro"
  instance_ips = ["10.0.1.20", "10.0.1.21"]
  ami = {
    us-east-1 = "ami-04d29b6f966df1537"
    us-west-1 = "ami-08d9a394ac1c2994c"
  }
}



