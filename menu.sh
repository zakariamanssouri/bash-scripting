#!/bin/bash

#file conditions

function checkParams(){
	if [[ -z "$1" ]]
	then
		echo "params is mandatory"
		exit 1;
	fi
}

function checkFile(){
	if [[ -f $1 ]];then
		echo "==================================="
		echo "$1 is a file"
		checkSize $1
		echo "==================================="
	elif [[ -d $1 ]];then
		echo "$1 is a directory"
	fi
}

function checkSize(){
	if [[ -s $1 ]];then
		echo "Size is >0 bytes"
	fi
}

function checkIfExecutable(){
	if [[ -x $1 ]];then
		echo "Size is >0 bytes"
	fi
}
checkParams $1
currentDir=$1
#

#loops
option='';
while [[ $option != "Q" ]];
do
echo "====================== Menu =============================="
echo "1)Print date"
echo "2)List directory"
echo "3)Get current user"
echo "4)Get  the  available free memory on server"
echo "5)Get the IP adresse"
echo "Q)Quit"
echo "====================== Menu =============================="
echo -e "Your Option : \c"
read option
clear
case $option in
	1)
		echo $(date)
		read
		;;
	2)
		for i in $(ls);do
			echo -e "\n $i"
		done
		;;
	3)
		whoami
		;;
	4)
		echo $(free -h |grep -Ei Mem |awk '{print $7}')
			;;
	5)	ip a
		;;
	Q) exit 0;;
esac
done
