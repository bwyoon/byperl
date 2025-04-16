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
my $nspins   = $procar->{'spinox'}+1; 
my $nkpoints = $procar->{'nkpoints'};
my $nbands   = $procar->{'nbands'};

my $natoms = scalar(@ARGV)-1;

my $sums;
my $sump;
my $sumd;
my $sumt;

for (my $k = 0; $k < $nkpoints; $k++) {
    print "$procar->{'kpointinfo'}[0][$k]\n";
    if ($nspins == 1) {
        print "E(eV) occ s p d tot\n";
    } else {
        print "E(eV) occ s p d tot E(eV) occ s p d tot\n";
    }

    for (my $b = 0; $b < $nbands; $b++) {
        for ($spin = 0; $spin < $nspins; $spin++) {
            $sums = $sump = $sumd = $sumt = 0.0;
            for ($n = 0; $n < $natoms; $n++) {
                my $atom = $ARGV[$n+1]-1;
                $sums += $procar->{'data'}[$spin][$k][$b][$atom]{'s'};
                $sump += $procar->{'data'}[$spin][$k][$b][$atom]{'p'};
                $sumd += $procar->{'data'}[$spin][$k][$b][$atom]{'d'};
                $sumt += $procar->{'data'}[$spin][$k][$b][$atom]{'tot'};
            }

            my $e = $procar->{'energy'}[$spin][$k][$b];
            my $o = $procar->{'occ'}[$spin][$k][$b];
            printf("%.8f %.8f %.10f %.10f %.10f %.10f", $e, $o,
                        $sums, $sump, $sumd, $sumt);
            if (($nspins == 2) && ($spin == 0)) {
                print " "
            } else {
                print "\n"
            }
        }
    }
}

