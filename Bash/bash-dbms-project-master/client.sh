#!/bin/bash
id=$1

#trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
	rm client$id.pipe
	exit 0
}


if [ ! $# -eq 1 ]; then
	echo "Error, incorrect parameter"
else 
	mkfifo client$id.pipe	
	while true; do
	        echo please input
		read task database table data
		echo $id $task $database $table $data > server.pipe
		read result < client$id.pipe
		ju=`echo $result | grep -c start`
		echo $result
		while [ $ju -eq 1 ]; do
			read data < client$id.pipe
			echo $data
			ju=`echo $data | grep -c end`
			ju=$((ju+1))
		done
		sj=`echo $result | grep -c shutdown`
		if [ $sj -gt 0 ]; then
			rm client$id.pipe
			exit 0
		fi		
		sleep 1
	done											    
fi
