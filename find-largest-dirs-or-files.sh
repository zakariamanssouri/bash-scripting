#!/bin/bash


echo "=================Find the Largest N Files Or Dirs in A Directory ===================="
echo -e "\t\t Full Path DIRECTORY :\c"
read directory
echo -e "\t\t Number of files to be displayed :\c"
read n
du -ck $(echo "$directory/*") | sort -nr | head -$n |tr -s ' ' |cut -d' ' -f1 | tail -n +2
echo "======================================================================================"
