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
print "HOMO $homo";

my $nband = `outcarbandcount.pl $fn`;

my @lines;
my $n = 0;

open(IN, "<$fn");
while (<IN>) {
    if (/band No.\s*band energies/ .. /------------/) {
        $n = 0 if (/band No.\s*band energies/);
        $line[$n++] = $_;
    }
}
close(IN);

for (my $n = 1; $n <= $nband; $n++) {
    print join(" ", split(" ", $line[$n]));
    print "\n";
}

