#!bin/bash


no_clr ='\033[0m'         # white
red='\033[0;31m'          # Red
green='\033[0;32m'        # Green


if [ "$UID" -eq "0" ]

    then 
        systemctl status nginx | grep "running" || {
            echo -e "${red}NGINX is Dead. Do you want to run NGINX [y/n]?${no_clr}"
            read input

            if [ "$input" = "y" ] 
                then

                    systemctl start nginx

                    if [ "$?" -eq "0" ]
                        then
                            echo "Nginx is activated"

                    else
                        echo -e "${red}Something went wrong, NGINX cannot be activated${no_clr}"
                    fi
            && echo -e "${Green}Nginx is Running${no_clr}" 
        }

else
    echo "You're not a sudo user, kindly switch to sudo user"
    exit
fi

