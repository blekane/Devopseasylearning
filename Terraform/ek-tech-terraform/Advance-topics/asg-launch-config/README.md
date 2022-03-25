### map and format
* "%s-repository" for no arg >> "mam-dev-repository"
```tf
bucket = format("%s-repository", var.tags["environment"])
```

* %s-repository-%s for 1 arg >> "mam-dev-repository-us-east-1"
```tf
resource "aws_s3_bucket" "repository" {
  bucket = format("%s-repository-%s", var.tags["environment"], data.aws_region.current.name)
```

* %s-repository-%s for 2 args >> mam-dev-repository-us-east-1-788210522308
```tf
bucket = format("%s-repository-%s-%s", var.tags["environment"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)
```

```
tags   = merge(map("Name", format("%s-repository-%s-%s", var.tags["environment"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)), map("csp_exception", "true"), map("Others tags", "just for for testing"), var.tags)
```

* "%s-repository-%s-%s-%s" for 3 args >> "mam-dev-repository-82540-us-east-1-788210522308"
```tf
bucket = format("%s-repository-%s-%s-%s", var.tags["environment"], var.tags["project-id"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)
```
* "%s-repository-%s-%s-%s-%s" for 5 args  and so on