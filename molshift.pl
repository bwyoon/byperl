#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;

if (scalar @ARGV < 5) {
    print STDERR "USAGE: molshift.pl infile outfile dx dy dz [atomfrom atomtp]\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my $atomfrom = (scalar(@ARGV) >= 7) ? $ARGV[5]-1 : 0;
my $atomto   = (scalar(@ARGV) >= 7) ? $ARGV[6]-1 : $mol->GetAtomCount()-1;
my @dpos = @ARGV[2 .. 4];

for (my $n = $atomfrom; $n <= $atomto; $n++) {
    for (my $m = 0; $m < 3; $m++) {
       $mol->{'pos'}[$n][$m] += $dpos[$m];
    }
}

$mol->WriteFile($ARGV[1]);

