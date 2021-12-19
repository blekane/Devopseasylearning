## Working with json files using python
To use json file in python, we need to convert json file into a list.
### Print json file
```py
import json 

#Read a json file
req_file="my_file1.json"

fo=open(req_file,'r')
print(fo.read())

# print(json.load(fo))
fo.close()
```

```json
# OUTPUT
{
    "Version": "2012-10-17",
    "Id": "S3PolicyId1",
    "Statement": [
      {
        "Sid": "IPAllow",
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:*",
        "Resource": [
       "arn:aws:s3:::awsexamplebucket1",
           "arn:aws:s3:::awsexamplebucket1/*"
        ],
        "Condition": {
       "NotIpAddress": {"aws:SourceIp": "54.240.143.0/24"}
        }
      }
    ]
  }
```

### Print json file as a dictionary
```py
import json 

#Read a json file
req_file="my_file1.json"

fo=open(req_file,'r')
print(json.load(fo))
fo.close()

# OUTPUT
{'Version': '2012-10-17', 'Id': 'S3PolicyId1', 'Statement': [{'Sid': 'IPAllow', 'Effect': 'Deny', 'Principal': '*', 'Action': 's3:*', 'Resource': ['arn:aws:s3:::awsexamplebucket1', 'arn:aws:s3:::awsexamplebucket1/*'], 'Condition': {'NotIpAddress': {'aws:SourceIp': '54.240.143.0/24'}}}]}
```

### Create a json file 
```py
import json 

#Write data(dictionary data) into a json file
my_dict={'Name_1':'Narendra','skills_Narendra':['Python','Azue','yaml','AWS'],'Name2':'Paul','skills_Paul':['Java','Ansible','Git','Jenkins']}

req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working_With_Json\\my_file2.json"

fo=open(req_file,'w')
json.dump(my_dict,fo,indent=4)
fo.close()

fo=open(req_file,'r')
print(json.load(fo))
fo.close()

#OUTPUT
{'Name_1': 'Narendra', 'skills_Narendra': ['Python', 'Azue', 'yaml', 'AWS'], 'Name2': 'Paul', 'skills_Paul': ['Java', 'Ansible', 'Git', 'Jenkins']}
```

```json
{
    "Name_1": "Narendra",
    "skills_Narendra": [
        "Python",
        "Azue",
        "yaml",
        "AWS"
    ],
    "Name2": "Paul",
    "skills_Paul": [
        "Java",
        "Ansible",
        "Git",
        "Jenkins"
    ]
}
```

```py
import json 

#Write data(dictionary data) into a json file
my_dict={'Name_1':'Narendra','skills_Narendra':['Python','Azue','yaml','AWS'],
'Name2':'Paul','skills_Paul':['Java','Ansible','Git','Jenkins'],
'Name3':'Jhon','skills_Jhon':['Nginx','Kubernets','Docker','Maven'],
'Name4':'Tom','skills_Tom':['C#','Nagios','SVN','TOMCAT']},


req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working_With_Json\\my_file2.json"

fo=open(req_file,'w')
json.dump(my_dict,fo,indent=4)
fo.close()

fo=open(req_file,'r')
print(json.load(fo))
fo.close()

#OUTPUT
[{'Name_1': 'Narendra', 'skills_Narendra': ['Python', 'Azue', 'yaml', 'AWS'], 'Name2': 'Paul', 'skills_Paul': ['Java', 'Ansible', 'Git', 'Jenkins'], 'Name3': 'Jhon', 'skills_Jhon': ['Nginx', 'Kubernets', 'Docker', 'Maven'], 'Name4': 'Tom', 'skills_Tom': ['C#', 'Nagios', 'SVN', 'TOMCAT']}]
```

```json
[
    {
        "Name_1": "Narendra",
        "skills_Narendra": [
            "Python",
            "Azue",
            "yaml",
            "AWS"
        ],
        "Name2": "Paul",
        "skills_Paul": [
            "Java",
            "Ansible",
            "Git",
            "Jenkins"
        ],
        "Name3": "Jhon",
        "skills_Jhon": [
            "Nginx",
            "Kubernets",
            "Docker",
            "Maven"
        ],
        "Name4": "Tom",
        "skills_Tom": [
            "C#",
            "Nagios",
            "SVN",
            "TOMCAT"
        ]
    }
]
```


```py
import json 
#Read a json file
'''
req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working_With_Json\\my_file1.json"

fo=open(req_file,'r')
#print(fo.read())
print(json.load(fo))

fo.close()
'''
#Write data(dictionary data) into a json file
my_dict={'Name':'Narendra','skills':['Python','shell','yaml','AWS']}

req_file="myinfo.json"

fo=open(req_file,'w')
json.dump(my_dict,fo,indent=4)

fo.close()
```