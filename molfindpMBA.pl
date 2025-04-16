#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;

if (scalar @ARGV < 3) {
    print STDERR "USAGE: USAGE: molfindpMBA.pl infile outfile sind\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my $sind = $ARGV[2]-1;
my $atomcount = $mol->GetAtomCount();
if (($sind >= $atomcount) || ($sind < 0)) {
    print STDERR "Invalid S index.\n";
    exit(1);
}

my @melem    = ("S", "C", "C", "C", "C", "C", "C", "C", "O", "O");
my @compind  = (  0,   0,   1,   1,   2,   3,   4,   6,   7,   7);
my @compdist = (0.0, 2.0, 1.7, 1.7, 1.7, 1.7, 1.7, 1.7, 1.5, 1.5); 

my @mind = $mol->FindMoleculeWithHs($sind, \@melem, \@compind, \@compdist);

my $mol2 =  BY::MolData->new;

exit(1) if (scalar(@mind) < scalar(@melem));

for (my $n = 0; $n < scalar(@mind); $n++) {
    my $e = $mol->GetAtomElem($mind[$n]);
    my @pos = $mol->GetAtomPos($mind[$n]);
    $mol2->AppendAtom($e, @pos);
}
$mol2->WriteFile($ARGV[1]);

