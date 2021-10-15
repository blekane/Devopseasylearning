#!/bin/bash

yum install httpd -y

cp /etc/ansible/roles/apache/files/httpd.conf /etc/httpd/conf/httpd.conf
cp /etc/ansible/roles/apache/files/index.html /var/www/html/index.html


service httpd restart
