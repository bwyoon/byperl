#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use OUTCAR;

my $fn = OUTCAR::getOUTCARfilename(@ARGV);
if ($fn eq "") {
   print STDERR "$fn not found.\n";
   exit(1);
}

open(IN, "<$fn");
while (<IN>) {
    if (/NELECT/) {
        s/^\s*NELECT\s*=\s*([^ ]+).+$/\1/;
        $val = $_/2;
        print "$val\n";
        last;
    }
}
close(IN);


