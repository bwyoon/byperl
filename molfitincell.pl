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
my $atomcount = $mol->GetAtomCount();
for (my $n = 0; $n < $atomcount; $n++) {
    my @spos = $mol->Unscaled2Scaled($mol->GetAtomPos($n));
    for (my $k = 0; $k < 3; $k++) {
        while ($spos[$k] <  0.0) { $spos[$k] += 1.0; }
        while ($spos[$k] >= 1.0) { $spos[$k] -= 1.0; }
    }
    $mol->SetAtomPos($n, $mol->Scaled2Unscaled(@spos));
} 
$mol->WriteFile($ARGV[1]);

