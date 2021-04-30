

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

	