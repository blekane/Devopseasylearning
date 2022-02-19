## Python shutil module
Python Shutil Module provide us a number of high-level operations on files and folders/directories like copy, move, remove and much more. 

### Help with shutil module
```py
import shutil 
print(dir(shutil))
```

### Differnt operations with shutil module
- **copyfile:** Copy file with different permission
- **copy:** Copy file with the same permissions for src and dest
- **copy2:** Copy file with the same meta data for dest as well
- **copymode:** Copy just the permission to the dest file without copying the content of the file
- **copystat:** Copy just the metadata (time the was created on so on) to the dest file without copying the content of the file
- **copytree:** Copy directory with subdirectory to destination with the same permission and metadata
- **rmtree:** To delete a directory tree
- **copyfileobj:** To copy the content of a file to another file

```py
#!/usr/local/bin/python3
import shutil
#copy', 'copy2', 'copyfile', 'copyfileobj', 'copymode', 'copystat', 'copytree'

#copyfile-->copy --> copy2
#src="/home/Automation/working_with_remote_server.py"
src="/home/Automation/shutil_part_1.py"
dest="/home/Automation/working_with_remote_server.py_bkp"
shutil.copyfile(src,dest)
shutil.copy(src,dest)   #same permissions for src and dest
shutil.copy2(src,dest)  #same meta data for dest as well
shutil.copymode(src,dest)
shutil.copystat(src,dest)

# copy the content of f1 to f2
f1=open('xyz.txt','r')
f2=open('pqr.txt','w')
shutil.copyfileobj(f1,f2)

# copy tomcat7 to /tmp call tomcat
src="/home/Automation/tomcat7"
shutil.copytree(src,'/tmp/tomcat')

# remove tomcat dir in /tmp
shutil.rmtree('/tmp/tomcat')

```

