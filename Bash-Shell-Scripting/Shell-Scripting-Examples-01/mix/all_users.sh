#! /bin/bash

#This script will pull all the users from /etc/passwd and display the output.

sed -n '/tcpdump/, /print still the end/p' /etc/passwd | awk -F":" '{print$1}' | sed '/tcpdump/d'| sort -u | less -NM > ~/users.txt

cd ~

sed -i '1i This Is All The Usernames On This Server.' users.txt

cat users.txt | less -NM

rm -f users.txt

exit 0

# awk -F":" '{print$1}' this will print the first line of /etc/passwd and use : as delimiter or filed separator
# sed '/tcpdump/d' this will delete the tcpdump in users.txt file
# sort -u this will sort the file in alphabetical order
# sed -n '/tcpdump/, /print still the end/p' this command will print all the usernames from tcpdump still the end
