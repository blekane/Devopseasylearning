#!/bin/bash






### Functions

usage() 
{
echo -e "\n This script needs 3 arguments the directory nme , the file and the username\n"
echo "               EXAMPLE: $0 <dir name> <file name> < username> "
exit 99
}

 



    [[ $# -ne 3 ]] && usage








DIR_NAME=$1
FILE_NAME=$2
USER_NAME=$3

mkdir ${DIR_NAME}

touch ${FILE_NAME}

useradd ${USER_NAME}

