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
my $le;
open(IN, "<$fn");
while (<IN>) {
    if (m/^\s*$homo/) {
        (undef, $he, undef) = split(" ");
        (undef, $le, undef) = split(" ", <IN>);
    }
}
close(IN);

my $val = $le-$he;
print "$val\n";

