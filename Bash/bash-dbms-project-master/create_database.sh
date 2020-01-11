#!/bin/bash

if [ $# -lt 2 ]; then
	echo "Error: no parameter" > client$1.pipe
	echo "Command excutes failed"
	exit 1
elif [ -d $2 ]; then
	echo "Error: DB already exist" > client$1.pipe
	echo "Command excutes failed"
	exit 2
else
	mkdir $2
	echo "OK: database created" > client$1.pipe
	echo "Command excutes successfully"
	exit 0
fi
