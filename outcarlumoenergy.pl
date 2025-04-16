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
my $lumo = $homo + 1;

my $iter = 0;
my $le;
open(IN, "<$fn");
while (<IN>) {
    (undef, $le, undef) = split(" ") if (m/^\s*$lumo/);
}
close(IN);

print "$le\n";
