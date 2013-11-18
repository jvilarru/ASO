#!/bin/bash
if [ $# -ne 0 ]; then
    if [ $# -ne 1 ]; then
	echo "Usage: deluser.sh user"; exit 1
    fi
fi
grep $1 /etc/passwd | cut -d: -f6 | tar zcf backup.$1.tar.gz
find / -user $1 -delete
chsh $1 -s /usr/local/lib/no-login
