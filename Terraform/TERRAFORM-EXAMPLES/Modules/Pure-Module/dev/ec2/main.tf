module "ec2" {
    source            = "../../terraform/ec2/"
    //source = "github.com/leonardtia1/test-module/terraform/ec2"
    aws-region        = "us-east-1"
    availability_zone = "us-east-1a"
    ami               = "ami-04bf6dcdc9ab498ca"
    key_name          = "jenkins-key"
    instance_type     = "t2.micro"
    private-key-path  = "C:\\Users\\Owner\\Downloads\\jenkins-key.pem"
    user              = "ec2-user"

}