#!/usr/bin/perl -w
$sais = @ARGV;
if($sais < 1 || $sais > 3) {
	print "Usage: perl backupFolder.pl Source ExcludeFile lastBackup";
	exit -1;
}
$date = `date +"%Y-%m-%d-%H-%M-%S"`;
chomp($date);
$arxiu = $ARGV[0];
$arxiu =~ s/\//_/;
$nom = "";
if($sais <= 2){
	$nom = "backup-$arxiu-nivell0-$date";
}
else{
	$nom = "backup-$arxiu-nivell1-$date";
}
if($sais == 3){
	`tar cf "$nom.tar" --newer $ARGV[2] -X $ARGV[1] $ARGV[0]`;
}
else{
	`tar cf "$nom.tar" --newer $ARGV[2] $ARGV[0]`;
}
`md5sum "$nom.tar" > "$nom.asc"`
