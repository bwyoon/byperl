#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;
use BY::Rotator;

if (scalar @ARGV < 5) {
    print STDERR "USAGE: molstretch.pl infile outfile atom1 atom2 distance\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my ($n1, $n2, $dist) = ($ARGV[2]-1, $ARGV[3]-1, $ARGV[4]);;
my $dd = ($dist-$mol->CalcDistance($n1, $n2))*0.5;
my @dp = map {$_*$dd} $mol->CalcUnitDirection($n1, $n2);

for (my $k = 0; $k < 3; $k++) {
    $mol->{'pos'}[$n1][$k] -= $dp[$k];
    $mol->{'pos'}[$n2][$k] += $dp[$k];
}

$mol->WriteFile($ARGV[1]);

