module "ec2" {
    source            = "../../terraform/vpc/"
    //source = "github.com/leonardtia1/test-module/terraform/ec2"
    aws-region       = "us-east-1"
    vpc_cdir         = "192.168.0.0/16"
    cdir-bloc-subnet = ["192.168.0.0/24", "192.168.1.0/24"]
    azs              = ["us-east-1a", "us-east-1b"]
    external-route   = "0.0.0.0/0"
}