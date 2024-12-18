#!/bin/bash
echo "Este es un mensaje" > ~/mensaje_user_data.txt
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl start httpd