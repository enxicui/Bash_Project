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
else 
	if [ $# -eq 2 ];then
		cat $2/$3
	else 
		N=`head -n 1 $2/$3 | tr "," "\n" | wc -l`
		n=`echo $4 | tr "," "\n" | sort | tail -n 1`
		l=`echo $4 | tr "," "\n" | sort | head -n 1`
    		if [ $l -lt 1 ] || [ $n -gt $N ]; then
			echo "Error: column does not exsit" > client$1.pipe
			echo "command excutes failed"
			exit 4
		else
			echo "start_result" > client$1.pipe
			cat $2/$3 | cut -d , -f $4 > abc
			while read line;do
				echo $line > client$1.pipe 
				sleep 0.1
			done < abc 
			echo "end_Result" > client$1.pipe
			echo "command excutes succeed"
			rm abc
			exit 0
		fi
	fi
fi
