#!/bin/bash

source task_02.sh
source task_03.sh

rm /var/www/html/*

wget https://github.com/syedfarazzz/static_website/archive/refs/heads/main.zip

unzip $PWD/main.zip

rm /var/www/html/*

mv static_website-main/static_web/* /var/www/html/

nginx_status=$(service nginx status | grep Active | awk '{print $2}')
    sed -i "s/nginx_status/$nginx_status/g" /var/www/html/index.html

nginx_version=$(apt info nginx | grep Version | awk -F "-" '{print$1}' | awk '{print$2}')
    sed -i "s/nginx_version/$nginx_version/g" /var/www/html/index.html

aws_version=$(aws --version | awk '{print$1}' | tr -d 'aws-' | tr -d 'cli/')
    sed -i "s/aws_version/$aws_version/g" /var/www/html/index.html

ec2_running=$(aws ec2 describe-instances --filters Name=instance-state-code,Values=16 --query 'Reservations[].Instances[].[InstanceId]' --output text | wc -l)
    sed -i "s/ec2_running/$ec2_running/g" /var/www/html/index.html

sg=$(aws ec2 describe-security-groups --query "SecurityGroups[*].{Name:GroupName}"  --output text | wc -l)
    sed -i "s/sg/$sg/g" /var/www/html/index.html
