#!/bin/bash


RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' 
directory=""
path=""
indent="\t\t"

#horizontal
for i in {1..80};do
	printf "${BLUE}="
done

echo -e "\n\t\tCopy Directory Or File to Remote Host Using Secure Copy ! "

printf "${NC}"
#vertical
getDir(){
	while [[ -z $directory ]]
	do
		echo -e "\t\tEnter The Directory Path: \c"
		read directory
		if [[ -z $directory ]];then
					echo -e "\t\t${RED}ERROR\t\tThe Dir Pathname Cannot Be Empty !! Re enter a valid dir ${NC} "
		elif [[ ! -e $directory ]];then
			echo -e "\t\t${RED}ERROR\t\tThe Dir dosen't exist Re enter a valid dir ${NC} "
		fi
	done
	
}

getRemotePath(){
	while [[ -z $path ]]
	do
		echo -e "\t\tEnter The Remote Path ,Format "user@ip:/path/to": \c"
		read path
		if [[ -z $path ]];then
			echo -e "\t\t${RED}ERROR The Path could not be empty Reenter a valid path${NC}"
		fi
	done
}


getDir
getRemotePath
scp -r ${directory:-$(pwd)} $(echo $path"/$directory")
if [[ $? -eq 0 ]];then
	echo -e "\t\t${GREEN}Copied Successfully"
fi
