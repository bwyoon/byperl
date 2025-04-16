#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;

if (scalar @ARGV < 2) {
    print STDERR "USAGE: molbl.pl molfile atom1 [atom2 ..]\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my $atomcount = scalar(@ARGV)-1;
for (my $n = 0; $n < $atomcount; $n++) {
    my @atominfo = $mol->GetAtom($ARGV[$n+1]-1);
    print "@atominfo\n" if (@atominfo != undef);
} 

