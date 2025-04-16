#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;
use BY::Rotator;
use BY::Vector;

if (scalar @ARGV < 4) {
    print STDERR "USAGE: USAGE: molpivotepMBA.pl infile outfile sind angle\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my $sind = $ARGV[2]-1;
my $angle = $ARGV[3]-1;
my $atomcount = $mol->GetAtomCount();

my @melem    = ("S", "C", "C", "C", "C", "C", "C", "C", "O", "O");
my @compind  = (  0,   0,   1,   1,   2,   3,   4,   6,   7,   7);
my @compdist = (0.0, 2.0, 1.7, 1.7, 1.7, 1.7, 1.7, 1.7, 1.5, 1.5);

my @mind = $mol->FindMoleculeWithHs($sind, \@melem, \@compind, \@compdist);

exit(1) if (scalar(@mind) < scalar(@melem));

my @pos1 = $mol->GetAtomPos($mind[0]);
my @pos2 = $mol->GetAtomPos($mind[6]);
my @axis = BY::Vector::Difference(\@pos1, \@pos2);

my $rot = BY::Rotator->new();
$rot->InitMatrix();
$rot->SetCenter(@pos1);
$rot->SetAxis(@axis);
$rot->Rotate($angle);

for (my $n = 0; $n < scalar(@mind); $n++) {
    @pos1 = $mol->GetAtomPos($mind[$n]);
    $mol->SetAtomPos($mind[$n], $rot->Transform(@pos1));
}

$mol->WriteFile($ARGV[1]);

