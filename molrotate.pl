#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;
use BY::Rotator;

if (scalar @ARGV < 9) {
    print STDERR "USAGE: molrotate.pl infile outfile centerx centery centerz axisx axisy axisz angle [atomfrom atomtp]\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my @cpos = @ARGV[2 .. 4];
my @apos = @ARGV[5 .. 7];
my $angle = $ARGV[8];
my $atomfrom = (scalar(@ARGV) >= 11) ? $ARGV[9]-1 : 0;
my $atomto   = (scalar(@ARGV) >= 11) ? $ARGV[10]-1 : $mol->GetAtomCount()-1;

my $rot = BY::Rotator->new;
$rot->InitMatrix();
$rot->SetCenter(@cpos);
$rot->SetAxis(@apos);
$rot->Rotate($angle);
for (my $n = $atomfrom; $n <= $atomto; $n++) {
    $mol->SetAtomPos($n, $rot->Transform($mol->GetAtomPos($n)));
}

$mol->WriteFile($ARGV[1]);

