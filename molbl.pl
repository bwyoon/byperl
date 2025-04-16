#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;

if (scalar @ARGV < 3) {
    print STDERR "USAGE: USAGE: molbl.pl molfile atom1 atom2\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my $bl = $mol->CalcDistance($ARGV[1]-1, $ARGV[2]-1);
print "$bl\n";

