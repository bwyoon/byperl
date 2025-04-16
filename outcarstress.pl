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
    $line = $_ if (/in kB/);
}
close(IN);

my @val = split(" ", $line);
shift @val;
shift @val;
print "@val\n";



