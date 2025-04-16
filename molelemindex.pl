#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;

if (scalar @ARGV < 2) {
    print STDERR "USAGE: molelemindex.pl molfile elem\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my $count = 0;
for (my $n = 0; $n < $mol->GetAtomCount(); $n++) {
    if ($mol->GetAtomElem($n) eq $ARGV[1]) {  
        printf("%d ", $n+1);
        $count++;
    }
}
print "\n" if ($count > 0);

