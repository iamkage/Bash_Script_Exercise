#!/bin/bash

read -p "Choose your file to save: " file

if [ -f "$file" ]; then
	echo "You file exist! Processing backup copy..."
	newfile=$(cp app.log "app.log_$(date +%Y-%m-%d)")
	echo "Your backup file is: "
	ls $newfile
    else 
	echo "ERROR! INVALID ARGUMENT."
	exit 1


fi
