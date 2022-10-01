#!/bin/bash

function getAndKillZombieProcesses(){
	pids=$(ps -aux | awk -F" " '{if($8 == "Z") print $2}' )  
	for i in $pids;do
		ppid=$(ps -o ppid=$i)
		kill -s SIGCHLD $ppid
	done
}


getAndKillZombieProcesses
