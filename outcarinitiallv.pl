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

my $iter = 0;
my @val;
open(IN, "<$fn");
while (<IN>) {
    if (/direct lattice vectors/) {
        ($val[0], $val[1], $val[2]) = split(" ", <IN>);
        ($val[3], $val[4], $val[5]) = split(" ", <IN>);
        ($val[6], $val[7], $val[8]) = split(" ", <IN>);
        print "$val[0] $val[1] $val[2]\n";
        print "$val[3] $val[4] $val[5]\n";
        print "$val[6] $val[7] $val[8]\n";
        last;
    } 
}
close(IN);

