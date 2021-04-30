## Working with csv files using python

### First of all, what is a CSV ?
- CSV --> Comma Separated Values
- It is a simple file format used to store tabular data, such as a spreadsheet/excel or database.
- CSV is convenient way to export data to spreadsheets and databases as well as import or use it in other programs.


### Working with csv with "," as delimiter
```py
import csv 
req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working-with-csv\\info1.csv"

fo=open(req_file,"r")
content=csv.reader(fo,delimiter=",")
for each in content:
	print(each)

fo.close()

#OUTPUT
['KEYS', 'Name', 'Salary', 'Skill']
['1', 'Jhon', '$2000', 'Python']
['2', 'Json', '$3000', 'Bash']
['3', 'Tom', '$4000', 'Ansible']
```

### Working with csv with "|" as delimiter
```py
import csv 
req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working-with-csv\\info2.csv"

fo=open(req_file,"r")
content=csv.reader(fo,delimiter=",")
for each in content:
	print(each)

fo.close()

#OUTPUT
['KEYS', 'Name', 'Salary', 'Skill']
['1', 'Jhon', '$2000', 'Python']
['2', 'Json', '$3000', 'Bash']
['3', 'Tom', '$4000', 'Ansible']
```

### How to get header in a csv file
```py
import csv 
req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working-with-csv\\info1.csv"

fo=open(req_file,"r")
content=csv.reader(fo,delimiter=",")
my_list=list(content)
print(my_list)
print('')
print(f'The header is:\n {my_list[0]}')

#OUTPUT
[['KEYS', 'Name', 'Salary', 'Skill'], ['1', 'Jhon', '$2000', 'Python'], ['2', 'Json', '$3000', 'Bash'], ['3', 'Tom', '$4000', 'Ansible']]

The header is:
 ['KEYS', 'Name', 'Salary', 'Skill']
 ```

```py
import csv 
req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working-with-csv\\info1.csv"

fo=open(req_file,"r")
content=csv.reader(fo,delimiter=",")
header=next(content)
print(f'The header is: {header}')

#OUTPUT
The header is: ['KEYS', 'Name', 'Salary', 'Skill']
```


## How to get the number of rows in a csv file
### Print the row and remove the header
```py
import csv 
req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working-with-csv\\info1.csv"

fo=open(req_file,"r")
content=csv.reader(fo,delimiter=",")
print('The number of rows are:', len(list(content))-1)

#OUTPUT
The number of rows are: 3
```

### Print the row with the header
```py
import csv 
req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working-with-csv\\info1.csv"

fo=open(req_file,"r")
content=csv.reader(fo,delimiter=",")
number_co=len(list(content))
print(f'The number of rows are: {number_co}')

#OUTPUT
The number of rows are: 4
```

```py
import csv 
req_file="C:\\Users\\Automation\\Desktop\\hi\\new_info.csv"

fo=open(req_file,"r")
content=csv.reader(fo,delimiter="|")
#print(list(content))
#print(f'The header is:\n {list(content)[0]}')
#header=next(content)
#print("The header is: ",header)
print("The no of rows are: ",len(list(content))-1)
'''
for each in content:
	print(each)
'''
fo.close()
```

## Creating csv file
### Read a file
```py
import csv
req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working-with-csv\\info1.csv"

fo=open(req_file,'r')
csv_reader=csv.reader(fo,delimiter=",")
for each_row in csv_reader:
	print(each_row)
fo.close()

#OUTPUT
['KEYS', 'Name', 'Salary', 'Skill']
['1', 'Jhon', '$2000', 'Python']
['2', 'Json', '$3000', 'Bash']
['3', 'Tom', '$4000', 'Ansible']
```

### Create info3.csv
```py
import csv
req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working-with-csv\\info3.csv"

fo=open(req_file,'w',newline="")
csv_writer=csv.writer(fo,delimiter=",")

csv_writer.writerow(['S_No',"Name",'Age','Phone Number', 'Address'])
csv_writer.writerow([1,"John",23,75832554,'352 Drive'])
csv_writer.writerow([2,"Cliton",24,83286576,'352 Dr Houston'])
csv_writer.writerow([2,"Paul",35,74854564,'352 Beechut St'])

fo.close()
```

```py
import csv
req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working-with-csv\\info4.csv"

fo=open(req_file,'w',newline="")
csv_writer=csv.writer(fo,delimiter=",")

my_data=[['S_No',"Name",'Age'],[1,"John",23],[2,"Cliton",24]]
csv_writer.writerows(my_data)
fo.close()
```

```py
a=3
b=5
c=8
e='hello'
d=[a,b,c,e]
print(d)

#OUTPUT
[3, 5, 8, 'hello']
```

```py
import csv
req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working-with-csv\\info5.csv"

fo=open(req_file,'w',newline="")
csv_writer=csv.writer(fo,delimiter=",")

Java_Version_DB, Git_version_DB, Momery_Available_DB, Disk_Usage_DB='1.8', 2.6, 5, 6000
Java_Version_WEB, Git_version_WEB, Momery_Available_WEB, Disk_Usage_WEB='1.8', 2.0, 8, 7000
Java_Version_TEST, Git_version_TEST, Momery_Available_TEST, Disk_Usage_TEST='1.9', 6.0, 2, 5000

csv_writer.writerow(['Server Name',"Java Version",'Git version','Momery Available', 'Disk Usage'])
csv_writer.writerow(['DB server',Java_Version_DB, Git_version_DB, Momery_Available_DB, Disk_Usage_DB])
csv_writer.writerow(['Web server',Java_Version_WEB, Git_version_WEB, Momery_Available_WEB, Disk_Usage_WEB])
csv_writer.writerow(['Test Server',Java_Version_TEST, Git_version_TEST, Momery_Available_TEST, Disk_Usage_TEST])

fo.close()


fo2=open(req_file,'r')
csv_reader=csv.reader(fo2,delimiter=",")
for each_row in csv_reader:
	print(each_row)
fo2.close()

#OUTPUT
['Server Name', 'Java Version', 'Git version', 'Momery Available', 'Disk Usage']
['DB server', '1.8', '2.6', '5', '6000']
['Web server', '1.8', '2.0', '8', '7000']
['Test Server', '1.9', '6.0', '2', '5000']
```

```py
import csv
name = input("Enter your name: ")
age = input("Enter your age: ")
address = input("Enter your address: ")
phone = input("Enter your phone number: ")

req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working-with-csv\\info6.csv"

fo=open(req_file,'a',newline="")
csv_writer=csv.writer(fo,delimiter=",")

csv_writer.writerow(["Name",'Age','Phone Number', 'Address'])
csv_writer.writerow([name, age, address, phone])

fo.close()

fo2=open(req_file,'r')
csv_reader=csv.reader(fo2,delimiter=",")
for each_row in csv_reader:
	print(each_row)
fo2.close()

#OUTPUT
$ python script.py
Enter your name: Jhon Smith
Enter your age: 25
Enter your address: 5500 Beechnut St
Enter your phone number: 835 875 3545
['Name', 'Age', 'Phone Number', 'Address']
['Jhon Smith', '25', '5500 Beechnut St', '835 875 3545']
```

```py
import csv

def header():
	req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working-with-csv\\info7.csv"

	fo=open(req_file,'w',newline="")
	csv_writer=csv.writer(fo,delimiter=",")

	csv_writer.writerow(["Name",'Age','Phone Number', 'Address'])
	
	fo.close()
# header()


def info():
	name = input("Enter your name: ")
	age = input("Enter your age: ")
	address = input("Enter your address: ")
	phone = input("Enter your phone number: ")

	req_file="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING\\Working-with-csv\\info7.csv"

	fo=open(req_file,'a',newline="")
	csv_writer=csv.writer(fo,delimiter=",")

	csv_writer.writerow([name, age, address, phone])

	fo.close()

	fo2=open(req_file,'r')
	csv_reader=csv.reader(fo2,delimiter=",")
	for each_row in csv_reader:
		print(each_row)
	fo2.close()

info()
```


```py
import csv
#req_file="C:\\Users\\Automation\\Desktop\\hi\\new_info.csv"
'''
fo=open(req_file,'r')
csv_reader=csv.reader(fo,delimiter="|")
for each_row in csv_reader:
	print(each_row)
fo.close()
'''
req_file="C:\\Users\\Automation\\Desktop\\hi\\demo.csv"
fo=open(req_file,'w',newline="")
csv_writer=csv.writer(fo,delimiter=",")
'''
csv_writer.writerow(['S_No',"Name",'Age'])
csv_writer.writerow([1,"John",23])
csv_writer.writerow([2,"Cliton",24])
'''
my_data=[['S_No',"Name",'Age'],[1,"John",23],[2,"Cliton",24]]
csv_writer.writerows(my_data)
fo.close()
```

```py
my_dict=['Name','Narendra','skills','Python','shell','yaml','AWS']
print(my_dict)

my_dict=['Name',
'Narendra',
'skills',
'Python','shell',
'yaml','AWS']
print(my_dict)

#OUTPUT
['Name', 'Narendra', 'skills', 'Python', 'shell', 'yaml', 'AWS']
['Name', 'Narendra', 'skills', 'Python', 'shell', 'yaml', 'AWS']
```