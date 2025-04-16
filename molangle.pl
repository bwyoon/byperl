#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;
use Math::Trig;

if (scalar @ARGV < 4) {
    print STDERR "USAGE: molangle.pl molfile atom1 atom2 atom3\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my $angle = $mol->CalcAngle($ARGV[1]-1, $ARGV[2]-1, $ARGV[3]-1)*180.0/pi;
print "$angle\n";

