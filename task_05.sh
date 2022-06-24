#!bin/bash

E_NOTROOT=100

AWS_ACCESS_KEY_ID=$(aws --region=us-east-1 ssm get-parameter --name "Access_key" --with-decryption --output text --query Parameter.Value)
AWS_SECRET_ACCESS_KEY=$(aws --region=us-east-1 ssm get-parameter --name "Private_key" --with-decryption --output text --query Parameter.Value)
AWS_DEFAULT_REGION=us-east-1

#EC2 DETAILS
AMI="ami-08d4ac5b634553e16"
COUNT=1
INSTANCE_TYPE="t2.micro"
KEY_NAME="assignment-02-kp"
SUBNET_ID="subnet-068676556e1b7dc99"
TAG='ResourceType=instance,Tags=[{Key=Name,Value=UbuntuServer_1}]'
SG="sg-0a86b973c6f991025"

# For second instance
SUBNET_ID_2="subnet-07b3dccc1151da98a"
TAG_2='ResourceType=instance,Tags=[{Key=Name,Value=UbuntuServer_2}]'

if [ "$UID" -ne "0" ]
    then
        echo "Must be root to run this script."
        exit $E_NOTROOT
fi  

source task_04.sh

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region $AWS_DEFAULT_REGION

echo "Launcing Instance#1"
aws ec2 run-instances \
	--image-id $AMI \
	--count $COUNT \
	--instance-type $INSTANCE_TYPE \
	--key-name $KEY_NAME \
	--security-group-ids $SG \
	--subnet-id $SUBNET_ID \
	--tag-specifications $TAG \

echo "Launcing Instance#2"
aws ec2 run-instances \
	--image-id $AMI \
	--count $COUNT \
	--instance-type $INSTANCE_TYPE \
	--key-name $KEY_NAME \
	--security-group-ids $SG \
	--subnet-id $SUBNET_ID_2 \
	--tag-specifications $TAG_2 \
