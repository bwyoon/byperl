#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;

if (scalar @ARGV < 2) {
    print STDERR "USAGE: moldup.pl infile outfile\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
$mol->WriteFile($ARGV[1]);

