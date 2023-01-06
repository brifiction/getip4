#!/bin/bash

cat << "EOF"
   _____ ______ _______ _____ _____  _  _   
  / ____|  ____|__   __|_   _|  __ \| || |  
 | |  __| |__     | |    | | | |__) | || |_ 
 | | |_ |  __|    | |    | | |  ___/|__   _|
 | |__| | |____   | |   _| |_| |       | |  
  \_____|______|  |_|  |_____|_|       |_|  

EOF

# Get Windows Ip4 address using Powershell
IP=$(powershell.exe "(Test-Connection -ComputerName (hostname) -Count 1).IPV4Address.IPAddressToString")

# Show output receipt of retrieved Windows Ip4 address
printf "\nWindows IP4 address: $IP\n"

# Prompt for full path to .env file
printf "\nPlease provide the full path to your .env file - such as /var/www/[project]/.env\n"
read envPath

# Prompt for environemnt variable name to target change
echo "Please provide single environment variable name - such as APP_NAME, DB_HOST etc :"
read envVarName

# BEGIN TEST READ FROM settings file
# export $(grep -v '^#' settings | xargs)

# echo $envPath
# echo $envVarName
# END TEST READ FROM settings file

# Handle exception if env file path invalid etc
if sed -i "s/^\\($envVarName=\\).*/\\1$IP/" $envPath
  then
    printf "\n>>>> The file $envPath has been updated\n\n"
else
    printf "\n>>>> Failed\n"
 fi

# Output entire file to review changes
cat $envPath