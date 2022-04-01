
## Terraform for AWS
* [Launching a VPC with Public & Private subnet & NAT Gateway in AWS using Terraform!](https://harshitdawar.medium.com/launching-a-vpc-with-public-private-subnet-nat-gateway-in-aws-using-terraform-99950c671ce9)
* [VPC with public and private subnet (NAT) on AWS using Terraform](https://medium.com/@kuldeep.rajpurohit/vpc-with-public-and-private-subnet-nat-on-aws-using-terraform-85a18d17c95e)



* [Provisioners | Terraform Tutorial](https://www.youtube.com/watch?v=uPKwNPomeJo)
* [terraform-course-examples](https://github.com/WillBrock/terraform-course-examples/blob/master/provisioners/main.tf)


### How can I use Terraform's file provisioner to copy from my local machine onto a VM?
https://stackoverflow.com/questions/48567881/how-can-i-use-terraforms-file-provisioner-to-copy-from-my-local-machine-onto-a

```tf
### Step 1: Creating a Provider for AWS!
# Specific provider name according to the use case has to given!
provider "<name of the provider>" {
  
  # Write the region name below in which your environment has to be deployed!
  region = "<region name>"

  # Assign the profile name here!
  profile = "default"
}


### Step 2: Creating an AWS keypair!
# Creating a New Key
resource "aws_key_pair" "Key-Pair" {

  # Name of the Key
  key_name   = "MyKeyFinal"

  # Adding the SSH authorized key !
  public_key = file("~/.ssh/authorized_keys")
 }


 ### Step 3: Create a VPC (Virtual Private Cloud in AWS)!
 # Creating a VPC!
resource "aws_vpc" "custom" {
  
  # IP Range for the VPC
  cidr_block = "192.168.0.0/16"
  
  # Enabling automatic hostname assigning
  enable_dns_hostnames = true
  tags = {
    Name = "custom"
  }
}


### Step 4: Create a Public Subnet with auto public IP Assignment enabled in custom VPC!
# Creating Public subnet!
resource "aws_subnet" "subnet1" {
  depends_on = [
    aws_vpc.custom
  ]
  
  # VPC in which subnet has to be created!
  vpc_id = aws_vpc.custom.id
  
  # IP Range of this subnet
  cidr_block = "192.168.0.0/24"
  
  # Data Center of this subnet.
  availability_zone = "ap-south-1a"
  
  # Enabling automatic public IP assignment on instance launch!
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}


### Step 5: Create a Private Subnet in customer VPC!
# Creating Public subnet!
resource "aws_subnet" "subnet2" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1
  ]
  
  # VPC in which subnet has to be created!
  vpc_id = aws_vpc.custom.id
  
  # IP Range of this subnet
  cidr_block = "192.168.1.0/24"
  
  # Data Center of this subnet.
  availability_zone = "ap-south-1b"
  
  tags = {
    Name = "Private Subnet"
  }
}


### Step 6: Creating an Internet Gateway!
# Creating an Internet Gateway for the VPC
resource "aws_internet_gateway" "Internet_Gateway" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2
  ]
  
  # VPC in which it has to be created!
  vpc_id = aws_vpc.custom.id

  tags = {
    Name = "IG-Public-&-Private-VPC"
  }
}


### Step 7: Create a routing table for Internet Gateway!
# Creating an Route Table for the public subnet!
resource "aws_route_table" "Public-Subnet-RT" {
  depends_on = [
    aws_vpc.custom,
    aws_internet_gateway.Internet_Gateway
  ]

   # VPC ID
  vpc_id = aws_vpc.custom.id

  # NAT Rule
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Internet_Gateway.id
  }

  tags = {
    Name = "Route Table for Internet Gateway"
  }
}


### Step 8: Associate the routing table to the Public Subnet!
# Creating a resource for the Route Table Association!
resource "aws_route_table_association" "RT-IG-Association" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2,
    aws_route_table.Public-Subnet-RT
  ]

# Public Subnet ID
  subnet_id      = aws_subnet.subnet1.id

#  Route Table ID
  route_table_id = aws_route_table.Public-Subnet-RT.id
}


### Step 9: Creating an Elastic IP for the NAT Gateway!
# Creating an Elastic IP for the NAT Gateway!
resource "aws_eip" "Nat-Gateway-EIP" {
  depends_on = [
    aws_route_table_association.RT-IG-Association
  ]
  vpc = true
}


### Step 10: Creating a NAT Gateway!
# Creating a NAT Gateway!
resource "aws_nat_gateway" "NAT_GATEWAY" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP
  ]

  # Allocating the Elastic IP to the NAT Gateway!
  allocation_id = aws_eip.Nat-Gateway-EIP.id
  
  # Associating it in the Public Subnet!
  subnet_id = aws_subnet.subnet1.id
  tags = {
    Name = "Nat-Gateway_Project"
  }
}


### Step 11: Creating a Route Table for the NAT Gateway!
# Creating a Route Table for the Nat Gateway!
resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.NAT_GATEWAY
  ]

  vpc_id = aws_vpc.custom.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY.id
  }

  tags = {
    Name = "Route Table for NAT Gateway"
  }

}


### Step 12: Associating the Route table for NAT Gateway to Public Subnet!
# Creating an Route Table Association of the NAT Gateway route 
# table with the Private Subnet!
resource "aws_route_table_association" "Nat-Gateway-RT-Association" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.subnet2.id

# Route Table ID
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}


### Step 13: Create a Security Group for the WordPress instance!
# Creating a Security Group for WordPress
resource "aws_security_group" "WS-SG" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2
  ]

  description = "HTTP, PING, SSH"

  # Name of the security Group!
  name = "webserver-sg"
  
  # VPC ID in which Security group has to be created!
  vpc_id = aws_vpc.custom.id

  # Created an inbound rule for webserver access!
  ingress {
    description = "HTTP for webserver"
    from_port   = 80
    to_port     = 80

    # Here adding tcp instead of http, because http in part of tcp only!
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Created an inbound rule for ping
  ingress {
    description = "Ping"
    from_port   = 0
    to_port     = 0
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Created an inbound rule for SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22

    # Here adding tcp instead of ssh, because ssh in part of tcp only!
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outward Network Traffic for the WordPress
  egress {
    description = "output from webserver"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#### Step 14: Create a Security Group for Mysql instance!
# Creating security group for MySQL, this will allow access only from the instances having the security group created above.
resource "aws_security_group" "MySQL-SG" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2,
    aws_security_group.WS-SG
  ]

  description = "MySQL Access only from the Webserver Instances!"
  name = "mysql-sg"
  vpc_id = aws_vpc.custom.id

  # Created an inbound rule for MySQL
  ingress {
    description = "MySQL Access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.WS-SG.id]
  }

  egress {
    description = "output from MySQL"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


### Step 15: Creating a Security Group for the Bastion Host!
# Creating security group for Bastion Host/Jump Box
resource "aws_security_group" "BH-SG" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2
  ]

  description = "MySQL Access only from the Webserver Instances!"
  name = "bastion-host-sg"
  vpc_id = aws_vpc.custom.id

  # Created an inbound rule for Bastion Host SSH
  ingress {
    description = "Bastion Host SG"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "output from Bastion Host"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


### Step 16: Creating a Security Group for the MySQL Instance which allows only bastion host to connect & do the updates!
# Creating security group for MySQL Bastion Host Access
resource "aws_security_group" "DB-SG-SSH" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2,
    aws_security_group.BH-SG
  ]

  description = "MySQL Bastion host access for updates!"
  name = "mysql-sg-bastion-host"
  vpc_id = aws_vpc.custom.id

  # Created an inbound rule for MySQL Bastion Host
  ingress {
    description = "Bastion Host SG"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.BH-SG.id]
  }

  egress {
    description = "output from MySQL BH"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


### Step 17: Launching a Webserver Instance hosting WordPress in it in public subnet!
# Creating an AWS instance for the Webserver!
resource "aws_instance" "webserver" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2,
    aws_security_group.BH-SG,
    aws_security_group.DB-SG-SSH
  ]
  
  # AMI ID [I have used my custom AMI which has some softwares pre installed]
  ami = "ami-0162dd7febeafb455"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet1.id

  # Keyname and security group are obtained from the reference of their instances created above!
  # Here I am providing the name of the key which is already uploaded on the AWS console.
  key_name = "MyKeyFinal"
  
  # Security groups to use!
  vpc_security_group_ids = [aws_security_group.WS-SG.id]

  tags = {
   Name = "Webserver_From_Terraform"
  }

  # Installing required softwares into the system!
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("/Users/harshitdawar/Github/AWS-CLI/MyKeyFinal.pem")
    host = aws_instance.webserver.public_ip
  }

  # Code for installing the softwares!
  provisioner "remote-exec" {
    inline = [
        "sudo yum update -y",
        "sudo yum install php php-mysqlnd httpd -y",
        "wget https://wordpress.org/wordpress-4.8.14.tar.gz",
        "tar -xzf wordpress-4.8.14.tar.gz",
        "sudo cp -r wordpress /var/www/html/",
        "sudo chown -R apache.apache /var/www/html/",
        "sudo systemctl start httpd",
        "sudo systemctl enable httpd",
        "sudo systemctl restart httpd"
    ]
  }
}


### Step 18: Launching a MySQL instance in the private subnet!
# Creating an AWS instance for the MySQL! It should be launched in the private subnet!
resource "aws_instance" "MySQL" {
  depends_on = [
    aws_instance.webserver,
  ]

  # Using my custom Private AMI which has most of the things configured for WordPress
  # i.e. MySQL Installed!
  ami = "ami-0f70942519a84d179"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet2.id

  # Keyname and security group are obtained from the reference of their instances created above!
  key_name = "MyKeyFinal"

  # Attaching 2 security groups here, 1 for the MySQL Database access by the Web-servers,
  # & other one for the Bastion Host access for applying updates & patches!
  vpc_security_group_ids = [aws_security_group.MySQL-SG.id, aws_security_group.DB-SG-SSH.id]

  tags = {
   Name = "MySQL_From_Terraform"
  }
}


### Step 19: Launching a Bastion Host instance in the public subnet!
# Creating an AWS instance for the Bastion Host, It should be launched in the public Subnet!
resource "aws_instance" "Bastion-Host" {
   depends_on = [
    aws_instance.webserver,
     aws_instance.MySQL
  ]
  
  ami = "ami-0162dd7febeafb455"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet1.id

  # Keyname and security group are obtained from the reference of their instances created above!
  key_name = "MyKeyFinal"
   
  # Security group ID's
  vpc_security_group_ids = [aws_security_group.BH-SG.id]
  tags = {
   Name = "Bastion_Host_From_Terraform"
  }
}
```
