#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;
use BY::Vector;

if (scalar @ARGV < 3) {
    print STDERR "USAGE: USAGE: molpickpMBA.pl infile outfile sind1 [sind2 ..]\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my $scount = scalar(@ARGV)-2;
my @sind;
for (my $n = 0; $n < $scount; $n++) { $sind[$n] = $ARGV[$n+2]-1; }
my $atomcount = $mol->GetAtomCount();

my @melem    = ("S", "C", "C", "C", "C", "C", "C", "C", "O", "O");
my @compind  = (  0,   0,   1,   1,   2,   3,   4,   6,   7,   7);
my @compdist = (0.0, 2.0, 1.7, 1.7, 1.7, 1.7, 1.7, 1.7, 1.5, 1.5);

my @ox = (0)x$atomcount;
for (my $n = 0; $n < $scount; $n++) {
    my @mind = $mol->FindMoleculeWithHs($sind[$n], \@melem, \@compind, \@compdist);
    if (scalar(@mind) >= scalar(@melem)) {
        for (my $m = 0; $m < scalar(@mind); $m++) { $ox[$mind[$m]] = 1; }
    }
}

my $mol2 = BY::MolData->new;
$mol2->SetComment($mol->GetComment());
$mol2->SetLatticeVectors($mol->GetLatticeVectors());
$mol2->SetCellOrigin($mol->GetCellOrigin());
    
for (my $n = 0; $n < $atomcount; $n++) {
    if ($ox[$n] == 1) {
        $mol2->AppendAtom($mol->GetAtomElem($n), $mol->GetAtomPos($n));
    }
}

$mol2->WriteFile($ARGV[1]);

