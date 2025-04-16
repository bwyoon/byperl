#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;

if (scalar @ARGV < 1) {
    print STDERR "USAGE: molatomcount.pl molfile\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
$n = $mol->GetAtomCount();
print "$n\n";

