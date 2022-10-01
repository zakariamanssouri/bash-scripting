#!/bin/bash

ps -aux | awk -F" " '{if($8 == "Z") print $1,$2,$8 }' 
