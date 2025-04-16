#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::VASP::PROCAR;

if (scalar(@ARGV) < 2) {
    print STDERR "USAGE: procarcollect.pl procarfile atom1 [atom2 ..]\n";
    exit(1)
}
my $procar = BY::VASP::PROCAR->ReadFile($ARGV[0]);
my $nions = $procar->{'nions'};
my $nbands = $procar->{'nbands'};
my @sums = 0 x $nbands;
my @sump = 0 x $nbands;
my @sumd = 0 x $nbands;
my @sumt = 0 x $nbands;

my $natoms = scalar(@ARGV)-1;

for (my $n = 0; $n < $natoms; $n++) {
    my $atom = $ARGV[$n+1]-1;
    for (my $b = 0; $b < $nbands; $b++) {
        $sums[$b] += $procar->{'data'}[0][0][$b][$atom]{'s'}; 
        $sump[$b] += $procar->{'data'}[0][0][$b][$atom]{'p'}; 
        $sumd[$b] += $procar->{'data'}[0][0][$b][$atom]{'d'}; 
        $sumt[$b] += $procar->{'data'}[0][0][$b][$atom]{'tot'}; 
    }
}

print "E(eV) s p d tot\n";
for (my $b = 0; $b < $nbands; $b++) {
    $e = $procar->{'energy'}[0][0][$b];
    printf("%.8f %.10f %.10f %.10f %.10f\n", $e, $sums[$b], $sump[$b], $sumd[$b], $sumt[$b]);
}
#
#
#print "SPINOX:   $procar->{'spinox'}\n";
#print "NKPOINTS: $procar->{'nkpoints'}\n";
#print "NBANDS:   $procar->{'nbands'}\n";
#print "NIONS:    $procar->{'nions'}\n";
#print "s1 k1 b1 i1 d: $procar->{'data'}[0][0][0][0]{'d'}\n";
#print "s1 k1 b21 i1 d: $procar->{'data'}[0][0][20][0]{'d'}\n";
#print "s2 k1 b1 i1 d: $procar->{'data'}[1][0][0][0]{'d'}\n";
#print "s2 k1 b21 i1 d: $procar->{'data'}[1][0][20][0]{'d'}\n";
