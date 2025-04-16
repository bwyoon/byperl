#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use warnings;

my $infn;
my @poscar;
my $description;
my $scalefactor;
my @argv;
my $argc;
my $i;
my $j;
my $lv;
my $line;
my @vec;
my @elem;
my @elemcount;
my $atomcount;
my $count;
my $index;
my $xyz;
my $sel;

@argv=@ARGV;
$argc=@ARGV;

#print "$argc\n";

$infn=$argv[0];

open(INFILE, $infn);
@poscar = <INFILE>;
close(INFILE);

chop(@poscar);

$description=$poscar[0];
$description=~s/\s+$//g;
$description=~s/^\s+//g;
#print "$description\n";

$scalefactor=$poscar[1];
$scalefactor=~s/\s+$//g;
$scalefactor=~s/^\s+//g;
#print "$scalefactor\n";

for ($i = 0; $i < 3; $i++) {
    $line = $poscar[2+$i];
    @vec  = split(" ", $line);
    for ($j = 0; $j < 3; $j++) {
        $lv->[$i][$j] = $vec[$j]*$scalefactor;
    }
}

#print "$lv->[0][0]\n";
#print "$lv->[1][1]\n";
#print "$lv->[2][2]\n";

$line=$poscar[5];
@elem=split(" ", $line);

#print "@elem\n";

$line=$poscar[6];
@elemcount=split(" ", $line);

$atomcount = 0;
for ($i = 0; $i < @elem; $i++) {
    $atomcount += $elemcount[$i];
}

$line = $poscar[7];
$line=~s/^\s+//;
if ($line=~/^s/i) {
    $selectox = 1;
    $line = $poscar[8];
    $line=~s/^\s+//;
    $index = 9;
} else {
    $selectox = 0;
    $index = 8;
}

for ($i = $index; $i < $index+$atomcount; $i++) {
    $line = $poscar[$i];
    @vec=split(" ", $line);
    for ($j = 0; $j < 3; $j++) {
        $xyz->[$i-$index][$j] = $vec[$j];
    }
    if ($selectox) {
       for ($j = 0; $j < 3; $j++) {
           $select->[$i-$index][$j] = $vec[$j+3];
       }
    }
    print "$xyz->[$i-$index][0] $xyz->[$i-$index][1] $xyz->[$i-$index][2] ";
    print "$select->[$i-$index][0] $select->[$i-$index][1] $select->[$i-$index][2]\n";
}


print "@elemcount\n";
print "$atomcount\n";






#foreach (@poscar) {
#   $_ =~ s/^\s+//g;
#}

#while (<INFILE>) {
#    $_ =~ s/^\s+//g;
#    $lines .= $_;
#}


