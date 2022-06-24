#!bin/bash
E_NOTSUDO=100

if [ "$UID" -eq "0" ]
    
then 
    which nginx &> /dev/null || {
        echo " Installing Nginx"
        apt update -y 
        apt upgrade -y
        apt install nginx -y
    } && {

    echo "Upgrading NGINX..."
    apt update -y 
    apt upgrade -y
    apt install nginx --upgrade
    }

else
    echo "You're not a sudo user, kindly switch to sudo user"
    exit $E_NOTSUDO
fi

