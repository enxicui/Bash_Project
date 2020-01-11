#!/bin/bash
mkfifo server.pipe

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT
function ctrl_c() {
        rm server.pipe
	exit 0
}

while true; do
	sleep 2
	read id task database table data < server.pipe

	if [ $task == "shutdown" ];then
		echo "system shutdown" > client$id.pipe
                rm server.pipe
                exit 0
	else

	while ! mkdir $database.lock ;do
		sleep 1
	done
	case "$task" in
		create_database)
			./create_database.sh "$id" "$database" 
			;;
		create_table)
			./create_table.sh "$id" "$database" "$table" "$data" 
			;;
		insert)
			./insert.sh "$id" "$database" "$table" "$data" 
			;;
		select)
			./select.sh "$id" "$database" "$table" "$data" 
			;;
		*)
			echo "Error: bad request"
			exit 1
	esac
	fi

rm -d $database.lock
done
