#!/bin/bash

if [ $# -ne 4 ]; then
	echo "Error: parameters problem" > client$1.pipe
	echo "command excutes failed"
	exit 1
elif [ ! -d $2 ]; then
	echo "Error: DB does not exist" > client$1.pipe
	echo "command excutes failed" 
	exit 2
elif [ ! -e $2/$3 ]; then
	echo "Error: table does not exist" > client$1.pipe
	echo "command excutes failed"
	exit 3
elif N=`head -n 1 $2/$3 | sed 's/,/\n/g' | wc -l`
     n=`echo $4 | sed 's/,/\n/g' | wc -l  `
     [ ! $n -eq $N ]; then
	echo "Error: number of columns in tuple does not match schema" > client$1.pipe
	echo "command excutes failed"
	exit 4
else
	echo $4 >> $2/$3
	echo "OK: tuple inserted" > client$1.pipe
	echo "command excutes successfully"
	exit 0
fi

