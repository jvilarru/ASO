#!/usr/bin/perl -w
$size = @ARGV;
$proc = ($size > 0 and $ARGV[0] eq "-p")?1:0;
$time = ($size > 1 and $ARGV[0] eq "-t")?1:0;
$timeval = 0;
if($time) {
	$timeval = substr($ARGV[1], 0, length($ARGV[1])-1);
	if (substr($ARGV[1], length($ARGV[1])-1, 1) eq "m") {
		$timeval = $timeval*30;
	}
}
$timeString = $time?"-mtime $timeval":" ";
open(PASSWD, "/etc/passwd") or die $!." "."/etc/passwd";
$i=0;
while ($p = <PASSWD>) { 
    @info = split(/:/, $p);
    $user = $info[0];
    
    if (-d $info[5] && `find $info[5] -type f $timeString -user $user -print -quit 2> /dev/null` ne ''){}
    else{
		if (($proc ||$time)&& `ps -u $user --no-headers` ne ''){}
		else{
			if($time && `lastlog -u $user -t $timeval` ne '' ){}
			else{
				$invalid_user[$i++] = $user;
			}
		}
    }
}

foreach $user_inv_id (sort(@invalid_user)){
    print "$user_inv_id\n";
}
close(PASSWD);
