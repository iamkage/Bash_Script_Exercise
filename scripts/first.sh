#!/bin/bash

read -p "Insert your file: " 

if  [ $# -eq 0 ]; then
	echo "ERROR! INVALID ARGUMENT"
	exit 1
fi

