#!/bin/bash

declare -A sounds #necessery
sounds[dog]="bark"
sounds[cow]="moo"
sounds[bird]="tweet"
sounds[wolf]="howl"


echo ${sounds[@]}

echo "all keys : ${!sounds[@]}"
echo "======================================"
for i in "${sounds[@]}"
do
	echo $i
done
echo "======================================"
