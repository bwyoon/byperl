#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;

if (scalar @ARGV < 3) {
    print STDERR "USAGE: molposmean.pl molfile atom1 atom2 [atom3 ...]\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my $atomcount = scalar(@ARGV)-1;
my @atoms;
for (my $n = 0; $n < $atomcount; $n++) {
    $atoms[$n] = $ARGV[$n+1]-1;
}

my @mean = (0)x3;

for (@atoms) {
    my @pos = $mol->GetAtomPos($_);
    for (my $m = 0; $m < 3; $m++) {
        $mean[$m] += $pos[$m];
    }
}
for (@mean) { $_ /= scalar(@atoms); };

print "@mean\n";

