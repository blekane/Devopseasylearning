#!/bin/bash







Syst=`uname`



if 
  [[ ${Syst} == Linux ]]

then 

/bin/grep -oq "^ansible:" /etc/passwd || useradd ansible 
/bin/grep -oq  TMP /home/ansible/.bash_profile || echo "TMP=/tmp" >> /home/ansible/.bash_profile
/bin/grep -oq  TMPDIR /home/ansible/.bash_profile || echo "TMPDIR=\$TMP" >> /home/ansible/.bash_profile

elif

  [[  ${Syst} == SunOS ]]

then  

/bin/grep ansible /etc/passwd || useradd ansible
/bin/grep -oq  TMP /home/ansible/.profile || echo "TMP=/tmp" >> /home/ansible/.profile
/bin/grep -oq  TMPDIR /home/ansible/.profile || echo "TMPDIR=\$TMP" >> /home/ansible/.profile
fi


