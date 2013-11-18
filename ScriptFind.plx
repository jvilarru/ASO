#!/usr/bin/perl -w
open(PASSWD, "/etc/passwd"); 
while ($p = <PASSWD>) { 
    $user = (split(/:/, $p))[0]; 
    if(`find / -user $user -type f -print -quit 2> /dev/null` ne ''){
	print $user,"\n"; 
    }
} 
close(PASSWD);
