#!/usr/bin/perl -w
$res = `find /home/uri/codi_lab_caso/ -type f -user uri -printf "%b+"`;
chop($res);
$res = $res."\n";
$pene = "echo $res | bc";
print `$pene`;
