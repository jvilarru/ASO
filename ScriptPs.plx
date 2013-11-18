#!/usr/bin/perl -w
open(PASSWD, "/etc/passwd"); 
while ($p = <PASSWD>) { 
    $user = (split(/:/, $p))[0]; 
    if(`ps -u $user` =~ tr/\n// > 1){
	print $user,"\n"; 
    }
} 
close(PASSWD);
