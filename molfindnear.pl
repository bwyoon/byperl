#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;

if (scalar @ARGV < 3) {
    print STDERR "USAGE: USAGE: molfindnear.pl molfile atom distancecutoff\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my $atom = $ARGV[1]-1;
my $dcutoff = $ARGV[2];
my $atomcount = $mol->GetAtomCount();

my $elem = $mol->GetAtomElem($atom);
my @pos  = $mol->GetAtomPos($atom);
printf("%5d %4s %10.5f %10.5f %10.5f : %10.5f\n", $atom+1, 
       $elem, $pos[0], $pos[1], $pos[2], 0.0);

for (my $n = 0; $n < $atomcount; $n++) {
    if ($n != $atom) {
        my $d = $mol->CalcDistance($atom, $n);
        if ($d < $dcutoff) {
            $elem = $mol->GetAtomElem($n);
            @pos  = $mol->GetAtomPos($n);
            printf("%5d %4s %10.5f %10.5f %10.5f : %10.5f\n", $n+1, 
                   $elem, $pos[0], $pos[1], $pos[2], $d);

        }
    }
}

