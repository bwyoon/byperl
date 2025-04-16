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
    $line = $_ if (/entropy=/);
}
close(IN);

print $line if ($line =~ s/^.*entropy=\s*([^ ]+).+$/\1/);

