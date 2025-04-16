#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

if (scalar @ARGV < 3) {
    print STDERR "preprocessprocar.pl procarfile dataoutfile ion1 [ion2 ...]\n";
    exit(1); 
}

open(IN, "<", $ARGV[0]);

my $nkpoints;
my $nbands;
my $nions;

while (<IN>) {
    if (/^\s*# of k-points:\s*([^ ]+)\s*# of bands:\s*([^ ]+)\s* # of ions:\s*([^ ]+)/) {
        $nkpoints = $1;
        $nbands = $2;
        $nions = $3; 
        chomp $nions;
        last;
    }
}

my $energy;
my $occ;
my $data;
for (my $k = 0; $k < $nkpoints; $k++) {
    while (<IN>) {
        last if (/^\s*k-point\s*([0-9]+).+$/);
    }
    for (my $b = 0; $b < $nbands; $b++) {
        while (<IN>) {
            if (/^\s*band\s*([^ ]+)\s*# energy\s*([^ ]+)\s*# occ\.\s*([^ ]+)/) {
                $energy->[$k][$b] = $2;
                $occ->[$k][$b] = $3;
                chomp $occ->[$k][$b];
                last;
            }
        }
        while (<IN>) {
            last if (/^\s*ion\s+/);
        }
        for (my $i = 0; $i < $nions; $i++) {
            my (undef, $s, $p, $d, $tot) = split(" ", <IN>);
            $data->[$k][$b][$i]{"s"} = $s;
            $data->[$k][$b][$i]{"p"} = $p;
            $data->[$k][$b][$i]{"d"} = $d;
            $data->[$k][$b][$i]{"tot"} = $tot;
            chomp($tot);
        }
    }
    last;
}

close(IN);

$ioncount = scalar @ARGV;
$ioncount -= 2;
my @ions;
for (my $n = 0; $n < $ioncount; $n++) {
    $ions[$n] = @ARGV[$n+2]-1;
}

my $datasum;

for (my $b; $b < $nbands; $b++) {
    $datasum->[0][$b]{'s'} = 0.0;
    $datasum->[0][$b]{'p'} = 0.0;
    $datasum->[0][$b]{'d'} = 0.0;
    $datasum->[0][$b]{'tot'} = 0.0;
    for (my $i = 0; $i < $ioncount; $i++) {
        $datasum->[0][$b]{'s'} += $data->[0][$b][$ions[$i]]{"s"};
        $datasum->[0][$b]{'p'} += $data->[0][$b][$ions[$i]]{"p"};
        $datasum->[0][$b]{'d'} += $data->[0][$b][$ions[$i]]{"d"};
        $datasum->[0][$b]{'tot'} += $data->[0][$b][$ions[$i]]{"tot"};
    }
}

open(OUT, ">", $ARGV[1]);

for (my $b = 0; $b < $nbands; $b++) {
    my $bb = $b+1;
    print OUT "$bb "; 
    print OUT "$datasum->[0][$b]{'s'} ";
    print OUT "$datasum->[0][$b]{'p'} ";
    print OUT "$datasum->[0][$b]{'d'}\n";
}

close(OUT);
