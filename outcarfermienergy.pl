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
    $line = $_ if (/E-fermi/);
}
close(IN);

print "$1\n" if ($line =~ /E-fermi\s*:\s*([^ ]+).+/);

