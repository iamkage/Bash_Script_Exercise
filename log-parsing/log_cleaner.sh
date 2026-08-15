#!/bin/bash


directory=""
n_days=""
force=false

while getopts "d:n:fh" opt; do
	case "${opt}" in
		d) directory="$OPTARG" ;;
		n) n_days="$OPTARG" ;;
		f) force=true ;; 
		h) echo "[HELP] $0 USAGE: [-d] <directory> [-n] <days_old> [-f] <force>"
			exit 0
			;;
		?) echo "[WARN] ERROR! INVALID ARGUMENT" 
			exit 1
			;;
			
	esac
done

shift $((OPTIND - 1))

if [[ -z "$directory" || -z "$n_days" ]]; then
	echo "[ERROR] Must be [-d] or [-n]"
	exit 1
fi

if [[ ! -d "$directory" ]]; then
	echo "[ERROR] Directory $directory does not exist"
	exit 1
fi

find_old_files() {
	local target_dir="$1"
	local days="$2"
	find "$target_dir" -type f -mtime +"$days" | awk '{print "FILE:" $1 }'
	if [[ "$force" == false ]]; then
		echo "[SIM] Files won't be eliminated. To delete files, Active [-f]"
	else 
		echo "[ACTION] Deleting files..." 	
	fi

}

find_old_files "$directory" "$n_days"

