#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;

if (scalar @ARGV < 2) {
    print STDERR "USAGE: moldup.pl infile outxyzfile\n";
    exit(1);
}

if ($ARGV[1] !~ /\.xyz$/i) {
    print STDERR "output file name does not have .xyz extension.\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
$mol->WriteFile($ARGV[1]);

