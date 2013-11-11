#!/bin/bash
#res = `find $home -type f -user $user -printf "%s"`;
p=0;
usage="Usage: $0 MAX_SIZE[M|K]";

group=""
if [ $# -gt 0 ]; then 
    if [ $# -eq 1 ]; then
		sized=${1:0:${#1}-1};
		typed=${1:${#1}-1:1};

		expr $sized + 1 2> /dev/null 1> /dev/null
		if [ $? != 0 ];then
			echo "Number not valid"
			exit 1;
		fi
		if [ $typed == "M" ]; then
			sized=$(expr $sized \* 1048576)
		elif [ $typed == "K" ]; then
			sized=$(expr $sized \* 1024)
		else
			exit 1;
		fi
    elif [ $# -eq 3 ]; then
		if [ $1 == "-g" ]; then
			sized=${3:0:${#3}-1};
			typed=${3:${#3}-1:1};
			group=$2
			expr $sized + 1 2> /dev/null 1> /dev/null
			if [ $? != 0 ];then
				echo "Number not valid"
				exit 1;
			fi
			if [ $typed == "M" ]; then
				sized=$(expr $sized \* 1048576)
			elif [ $typed == "K" ]; then
				sized=$(expr $sized \* 1024)
			else
				exit 1;
			fi
		else
			echo $usage;exit 1
		fi
    fi
else
	echo $usage;exit 1
    
fi

for user in `cut -d: -f1 /etc/passwd`; do
    home=`cat /etc/passwd | grep "^$user\>" | cut -d: -f6`
    if [ -d $home ]; then
		if [ $group == "" ]; then
			total_size=`find $home -type f -user $user -printf "+%s" 2> /dev/null | cut -c 2-| bc -l `
		else
			total_size=`find $home -type f -user $user -group $group -printf "+%s" 2> /dev/null | cut -c 2-| bc -l `
		fi
    else
		total_size=0
    fi
    
    if [[ $total_size -gt 0 ]] && [[ $total_size -le $sized ]]; then 
		printf "$user\t"
		if [[ $total_size -lt 1024 ]]; then
			printf "$total_size B\n"
		elif [[ $total_size -lt 1048576 ]]; then
			total_size=$(($total_size / 1024));
			printf "$total_size KB\n"
		elif [[ $total_size -lt 1073741824 ]]; then
			total_size=$(($total_size / 1048576));
			printf "$total_size MB\n"
		fi
	elif [[ $total_size -gt $sized ]]; then 
		`echo " echo \"S'ha d'esborrar barra comprimir algun fitxer\" " >> $home/.bash_profile`
		`chown $user $home/.bash_profile`
	fi
    
done
