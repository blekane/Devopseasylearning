### Bit
* cidrsubnet: it use to calculate subnets
* 8 is the number of bits
* if the numer of bit is 8, we have the below subnets.(255.255.255.0)
```tf
cidr_block = "${cidrsubnet(var.cidr_block, 8, count.index)}"

private_cidrs   = [
      + "10.0.3.0/24",
      + "10.0.4.0/24",
      + "10.0.5.0/24",
    ]

public_cidrs    = [
      + "10.0.0.0/24",
      + "10.0.1.0/24",
      + "10.0.2.0/24",
    ]
```

* if the numer of bit is 4, we have the below subnets.
```tf
cidr_block = "${cidrsubnet(var.cidr_block, 8, count.index)}"

+ private_cidrs   = [
      + "10.0.48.0/20",
      + "10.0.64.0/20",
      + "10.0.80.0/20",
    ]

  + public_cidrs    = [
      + "10.0.0.0/20",
      + "10.0.16.0/20",
      + "10.0.32.0/20",
    ]
```
* if the numer of bit is 10, we have the below subnets.
```tf
cidr_block = "${cidrsubnet(var.cidr_block, 10, count.index)}"
+ private_cidrs   = [
      + "10.0.0.192/26",
      + "10.0.1.0/26",
      + "10.0.1.64/26",
 
  + public_cidrs    = [
      + "10.0.0.0/26",
      + "10.0.0.64/26",
      + "10.0.0.128/26",
    ]
```
### Connect on the private from bastion 
* Store the in s3 
* Download it into a bastion and change the permission
```t
wget https://s3.amazonaws.com/linuxtraining.tk/bastion-key.pem
chmod 600 bastion-key.pem
ssh -i "bastion-key.pem" ec2-user@10.0.5.205
```
### Test on the private subnet
```
yum update -y
yum install -y tree
ping -c5 www.google.com
```

### RDS
* Put the DB on the public subnet so the you can test the connection