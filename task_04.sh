#!bin/bash

E_NOTSUDO =100
arch=$(uname -i)

if [ "$UID" -eq "0" ]

then 
which aws &> /dev/null || {
	
    which curl > /dev/null || apt install curl -y && echo "curl is installed"
    which unzip > /dev/null || apt install unzip -y && echo "unzip is installed"

    echo "Installing aws-cli"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-$arch.zip" -o "awscliv2.zip"
    
    unzip $PWD/awscliv2.zip
    $PWD/aws/install

    rm $PWD/awscliv2.zip

	} && {
       echo "aws-cli 2.7.9 is already installed in your machine"
       AWS_ACCESS_KEY_ID=$(aws --region=us-east-1 ssm get-parameter --name "Access_key" --with-decryption --output text --query Parameter.Value)
       echo ${AWS_ACCESS_KEY_ID}

       AWS_SECRET_ACCESS_KEY=$(aws --region=us-east-1 ssm get-parameter --name "Private_key" --with-decryption --output text --query Parameter.Value)
       echo ${AWS_SECRET_ACCESS_KEY}
	}


else
echo "You're not a sudo user, kindly switch to sudo user"
exit $E_NOTSUDO
fi

