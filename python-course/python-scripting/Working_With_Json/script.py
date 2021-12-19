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