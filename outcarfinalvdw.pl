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

my $line;

open(IN, "<$fn");
while (<IN>) {
    $line = $_ if (/vdW/);

}
close(IN);

print "$1" if ($line =~ /^.*\:\s*([^ ]+)\s*$/);

