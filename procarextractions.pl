#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::VASP::PROCAR;

my $procar = BY::VASP::PROCAR->ReadFile("PROCAR");

my $ioncount = scalar(@ARGV);

for (my $k = 0; $k < $procar->{'nkpoints'}; $k++) {
    print "k-point $k : $procar->{'kpointinfo'}[0][$k]\n";
    for (my $sp = 0; $sp < $procar->{'spinox'}+1; $sp++) {
        print "spin up\n" if ($sp == 0);
        print "spin down\n" if ($sp == 1);
        print "No E occ ";
        for ($i = 0; $i < $ioncount; $i++) {
            my $num = $ARGV[$i];
            print "$num ";
        } 
        print "\n";
        for (my $b = 0; $b < $procar->{'nbands'}; $b++) {
            my $bb = $b+1;
            print "$bb $procar->{'energy'}[$sp][$k][$b] ";
            print "$procar->{'occ'}[$sp][$k][$b] ";
            for ($i = 0; $i < $ioncount; $i++) {
                my $num = $ARGV[$i]-1;
                my $tot = $procar->{'data'}[$sp][$k][$b][$num]{"tot"};
                print "$tot ";
            } 
            print "\n";
        }
    }
}

print "$ioncount\n";

print "SPINOX:   $procar->{'spinox'}\n";
print "NKPOINTS: $procar->{'nkpoints'}\n";
print "NBANDS:   $procar->{'nbands'}\n";
print "NIONS:    $procar->{'nions'}\n";
print "s1 k1 b1 i1 d: $procar->{'data'}[0][0][0][0]{'d'}\n";
print "s1 k1 b21 i1 d: $procar->{'data'}[0][0][20][0]{'d'}\n";
print "s2 k1 b1 i1 d: $procar->{'data'}[1][0][0][0]{'d'}\n";
print "s2 k1 b21 i1 d: $procar->{'data'}[1][0][20][0]{'d'}\n";
