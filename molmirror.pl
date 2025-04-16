#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::MolData;
use BY::Mirror;

if (scalar @ARGV < 8) {
    print STDERR "USAGE: molmirror.pl infile outfile mposx mposy mposz normx normy normz [atomfrom atomtp]\n";
    exit(1);
}

my $mol = BY::MolData->ReadFile($ARGV[0]);
my @mpos = @ARGV[2 .. 4];
my @npos = @ARGV[5 .. 7];
my $atomfrom = (scalar(@ARGV) >= 10) ? $ARGV[8]-1 : 0;
my $atomto   = (scalar(@ARGV) >= 10) ? $ARGV[9]-1 : $mol->GetAtomCount()-1;

my $mir = BY::Mirror->new;
$mir->SetMirrorPosition(@mpos);
$mir->SetMirrorNorm(@npos);
for (my $n = $atomfrom; $n <= $atomto; $n++) {
    $mol->SetAtomPos($n, $mir->Transform($mol->GetAtomPos($n)));
}

$mol->WriteFile($ARGV[1]);

