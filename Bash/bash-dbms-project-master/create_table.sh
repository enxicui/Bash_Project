#!/bin/bash
if [ $# -ne 4 ]; then
	echo "Error: parameters problem" > client$1.pipe
	echo "command excutes failed"
	exit 1
elif [ ! -d $2 ]; then
	echo "Error: DB does not exist" > client$1.pipe
	echo "command excutes failed"
	exit 2
elif [ -e $2/$3 ]; then
	echo "Error: table already exist" > client$1.pipe
	echo "command excutes failed"
	exit 3
elif [ ! -e $2/$3 ]; then
	touch $2/$3
	echo $4 >> $2/$3
	echo "OK: table created" > client$1.pipe
	echo "command excutes successfully"
	exit 0
fi
