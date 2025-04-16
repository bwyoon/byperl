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

my $iter;

open(IN, "<$fn");
while (<IN>) {
    if (/Iteration/) {
        s/^.+Iteration\s+([^(]+).+$/\1/; 
        chomp;
        $iter = $_;
    } elsif (/entropy=/) {
        s/\s{2,}/ /g;
        chomp;
        print "$iter :$_\n";
    }
}
close(IN);
