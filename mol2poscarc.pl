#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;

if (scalar @ARGV < 2) {
    print STDERR "USAGE: molposcarc.pl infile outxyzfilei [lv11 ...]\n";
    exit(1);
}

if ($ARGV[1] !~ /\.poscar$/i && ($ARGV[1] !~ /POSCAR/i)) {
    print STDERR "output file name is not POSCAR type name.\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);

if (scalar @ARGV == 5) {
    my ($x, $y, $z) = ($ARGV[2], $ARGV[3], $ARGV[4]);    
    $mol->SetLatticeVectors($x, 0, 0, 0, $y, 0, 0, 0, $z);
} elsif (scalar @ARGV >= 11) {
    my @lv;
    for (my $n = 0; $n < 9; $n++) { $lv[$n] = $ARGV[$n+2]; }
    $mol->SetLatticeVectors(@lv);
} 
$mol->{'poscardirect'} = 0;
$mol->WriteFile($ARGV[1]);

