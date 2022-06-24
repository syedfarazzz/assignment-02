#!bin/bash

E_NOTSUDO =100
arch=$(uname -i)

if [ "$UID" -eq "0" ]

then 
    which aws &> /dev/null || {
	    echo "Installing aws-cli"
        which curl &> /dev/null || apt install curl -y && echo "curl is installed"
        which unzip &> /dev/null || apt install unzip -y && echo "unzip is installed"

        curl "https://awscli.amazonaws.com/awscli-exe-linux-$arch.zip" -o "awscliv2.zip"
    
        unzip $PWD/awscliv2.zip
        $PWD/aws/install

        rm $PWD/awscliv2.zip

	    } && {
            echo "aws-cli 2.7.9 is already installed in your machine"
	    }

else
echo "You're not a sudo user, kindly switch to sudo user"
exit $E_NOTSUDO
fi

