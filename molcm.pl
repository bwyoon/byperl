#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;

if (scalar @ARGV < 1) {
    print STDERR "USAGE: molcm.pl molfile [atomfrom atomtp]\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my $atomfrom = (scalar(@ARGV) >= 3) ? $ARGV[1]-1 : 0;
my $atomto   = (scalar(@ARGV) >= 3) ? $ARGV[2]-1 : $mol->GetAtomCount()-1;
my $atomcount = $atomto-$atomfrom+1;
my @cm = (0)x3;

for (my $n = $atomfrom; $n <= $atomto; $n++) {
    my @pos = $mol->GetAtomPos($n);
    for (my $m = 0; $m < 3; $m++) {
        $cm[$m] += $pos[$m];
    }
}
for (@cm) { $_ /= $atomcount; };

print "@cm\n";

