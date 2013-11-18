#!/usr/bin/perl
$size = @ARGV;
$proc = ($size >= 0 and $ARGV[0] eq "-p") 	?1:0;
open(PASSWD, "/etc/passwd") or die $!." "."/etc/passwd";
$i=0;
while ($p = <PASSWD>) { 
    @info = split(/:/, $p);
    $user = $info[0];
    if (-d $info[5] && `find $info[5] -type f -user $user -print -quit 2> /dev/null` ne ''){}
    elsif ($proc && `ps -u $user --no-headers` ne ''){}
    else{
	$invalid_user[$i++] = $user;
    }
}

foreach $user_inv_id (sort(@invalid_user)){
    print "$user_inv_id\n";
}
close(PASSWD);
