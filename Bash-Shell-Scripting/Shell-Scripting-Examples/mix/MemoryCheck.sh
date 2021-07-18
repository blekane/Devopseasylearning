#!/bin/bash



#This will display the memory usage every 10 minutes

## Function


usage() 

{
echo "This script will display the memory usage every 10 minutes"
}


watch -n 600 free -m 


