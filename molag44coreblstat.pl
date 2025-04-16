#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;
use BY::Vector;

if (scalar @ARGV < 1) {
    print STDERR "USAGE: USAGE: molag44coreblstat.pl molfile\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my $atomcount = $mol->GetAtomCount();

my $count = 0;
my @cma = (0)x3;
for (my $n = 0; $n < $atomcount; $n++) {
    my $elem = $mol->GetAtomElem($n);
    if (($elem =~ /Ag/) || ($elem =~ /Au/)) {
       my @pos = $mol->GetAtomPos($n); 
       @cma = map { $cma[$_]+$pos[$_] } (0 .. 2);
       $count++;
    }
}
@cma = map { $_/$count } @cma;

my @ind;
for (my $n = 0; $n < $atomcount; $n++) {
    my $elem = $mol->GetAtomElem($n);
    if (($elem =~ /Ag/) || ($elem =~ /Au/)) {
       my @pos = $mol->GetAtomPos($n); 
       push(@ind, $n) if (BY::Vector::Distance(\@pos, \@cma) < 3.7);
    }
}

my ($bl, $blsq) = (0.0, 0.0);
$count = 0;
for (my $n = 0; $n < 11; $n++) {
    for (my $m = $n+1; $m < 12; $m++) {
        my $d = $mol->CalcDistance($ind[$n], $ind[$m]);
        if ($d < 3.5) {
            $bl += $d;
            $blsq += $d*$d;
            $count++;
        }
    }
}
$bl /= $count;
$blsq /= $count;

printf "count: %d\n mean: %.5f\nstdev: %.5f\n",
       $count, $bl, sqrt($blsq-$bl*$bl);

