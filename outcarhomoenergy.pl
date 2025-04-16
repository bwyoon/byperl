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

my $homo = `outcarhomo.pl $fn`;
chomp($homo);

my $iter = 0;
my $he;
open(IN, "<$fn");
while (<IN>) {
    (undef, $he, undef) = split(" ") if (m/^\s*$homo/);
}
close(IN);

print "$he\n";
