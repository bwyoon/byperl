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
for (<IN>) {
    if (/  band No.  band energies/ .. /------------------------------/) {
        print;
    }
}
close(IN);

