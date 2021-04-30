#!/bin/bash

## check for a particular  string in a file

cd PATH_TO_YOUR_DIRECTORY #Changing directory to your working directory
File=YOUR_FILENAME  
if grep -q STRING_YOU_ARE_CHECKING_FOR "$File"; ##note the space after the string you are searching for
then
echo "Hooray!!It's available"
else
echo "Oops!!Not available"
fi
