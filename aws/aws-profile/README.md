## PROFILE 

[How to set up and work with AWS CLI profiles](https://www.youtube.com/watch?v=ptbxhz7TWmE)

### credentials
```s
[default]
aws_access_key_id = 
aws_secret_access_key = 

[dev]
aws_access_key_id = 
aws_secret_access_key = 

[prod]
aws_access_key_id = 
aws_secret_access_key =  

[stg]
aws_access_key_id = 
aws_secret_access_key = 

[qa]
aws_access_key_id = 
aws_secret_access_key = 

[tia]
aws_access_key_id = 
aws_secret_access_key = 
```

### Config
```s
[default]
region = us-west-2
output = json

[profile dev]
region = us-west-2
output = json

[profile qa]
region = us-west-2
output = json

[profile stg]
region = us-west-2
output = json

[profile prod]
region = us-east-1
output = json

[profile tia]
region = us-east-1
output = json
```

### Switch between profile
we need to export the profile every time that we need to switch to 
```
export AWS_PROFILE=dev
export AWS_PROFILE=qa
export AWS_PROFILE=stg
export AWS_PROFILE=prod
export AWS_PROFILE=tia
```

### Run commands with profile
```
aws s3 ls --profile tia
aws s3 ls --profile dev
aws s3 ls --profile prod
aws s3 ls --profile qa
aws s3 ls --profile stg
```

### list all the export profile
echo $AWS_PROFILE

### Check from AWS
```
aws sts get-caller-identity
```

### alias
```
alias awsd='export AWS_PROFILE=dev'
alias awsp='export AWS_PROFILE=prod'
alias awst='export AWS_PROFILE=tia'
alias awsp='echo $AWS_PROFILE'
alias awsg='aws sts get-caller-identity'
alias s3='aws s3 ls'
```

### AWS ADMIN ACCESS
```JSON
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
```

### AWS BUCKET PUBLIC ACCESS
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::BUCKET_NAME/*"
        }
    ]
}
```