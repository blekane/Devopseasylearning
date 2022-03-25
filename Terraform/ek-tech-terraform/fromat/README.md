

* The first instance will be web-1-bastion-asg, the scond web-2-bastion-asg
```tf
tags = {
    Name = "web-${format("%s-bastion-asg", count.index + 1)}"
  }
```

* The first instance will be web-001, the scond web-002
```tf
tags = {
    Name = "web-${format("%03d", count.index + 1)}"
  }
```
