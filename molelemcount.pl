#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;

if (scalar @ARGV < 1) {
    print STDERR "USAGE: molelemcount.pl molfile\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my @elems;
my %elemcount;
for (my $n = 0; $n < $mol->GetAtomCount(); $n++) {
    my $e = $mol->GetAtomElem($n);
    if (!exists($elemcount{$e})) {
        $elemcount{$e} = 0;
        push(@elems, $e);
    }
    $elemcount{$e}++;
}

for (my $n = 0; $n < scalar(@elems); $n++) {
    print "$elems[$n] $elemcount{$elems[$n]}\n";
}

