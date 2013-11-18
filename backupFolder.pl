#!/usr/bin/perl -w
$mida = @ARGV;
if($mida < 1 || $mida > 3) {
	print "Usage: perl backupFolder.pl Source [lastBackup] [ExcludeFile]";
	exit -1;
}
$date = `date +"%Y-%m-%d-%H-%M-%S"`;
chomp($date);
$arxiu = $ARGV[0];
$arxiu =~ s/\//_/;
$nom = "";
if($mida < 2){
	$nom = "backup-$arxiu-nivell0-$date";
}
else{
	$nom = "backup-$arxiu-nivell1-$date";
}

if($mida == 3){
	`tar cf "$nom.tar" --newer $ARGV[1] -X $ARGV[2] $ARGV[0]`;
}
elsif($mida == 2){
	`tar cf "$nom.tar" --newer $ARGV[1] $ARGV[0]`;
}
else{
	`tar cf "$nom.tar" $ARGV[0]`;
}
`md5sum "$nom.tar" > "$nom.asc"`
