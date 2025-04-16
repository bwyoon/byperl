#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

if (scalar @ARGV < 2) {
    print STDERR "preprocessprocar.pl procarfile dataoutfile\n";
    exit(1); 
}

open(IN, "<", $ARGV[0]);

my $nkpoints;
my $nbands;
my $nions;
my $nspins = 1;

while (<IN>) {
    if (/^\s*# of k-points:\s*([^ ]+)\s*# of bands:\s*([^ ]+)\s* # of ions:\s*([^ ]+)/) {
        $nkpoints = $1;
        $nbands = $2;
        $nions = $3; 
        chomp $nions;
        last;
    }
}

my $kpointinfo;
my $energy;
my $occ;
my $data;

for (my $spin = 0; $spin < $nspins; $spin++) {
    for (my $k = 0; $k < $nkpoints; $k++) {
        while (<IN>) {
            if (/^\s*k-point\s*([0-9]+).+$/) {
                chomp;
                $kpointinfo->[$spin][$k] = $_;
                last;
            }
        }
        for (my $b = 0; $b < $nbands; $b++) {
            while (<IN>) {
                if (/^\s*band\s*([^ ]+)\s*# energy\s*([^ ]+)\s*# occ\.\s*([^ ]+)/) {
                    $energy->[$spin][$k][$b] = $2;
                    $occ->[$spin][$k][$b] = $3;
                    if (($spin == 0) && ($k == 0) && ($b == 0)) {
                        $nspins = 2 if ($occ->[0][0][0] < 1.1);    
                    }
                    chomp $occ->[$spin][$k][$b];
                    last;
                }
            }
            while (<IN>) {
                last if (/^\s*ion\s+/);
            }
            for (my $i = 0; $i < $nions; $i++) {
                my (undef, $s, $p, $d, $tot) = split(" ", <IN>);
                $data->[$spin][$k][$b][$i]{"s"} = $s;
                $data->[$spin][$k][$b][$i]{"p"} = $p;
                $data->[$spin][$k][$b][$i]{"d"} = $d;
                $data->[$spin][$k][$b][$i]{"tot"} = $tot;
                chomp($tot);
            }
        }
    } 
}

close(IN);

open(OUT, ">", $ARGV[1]);

for ($k = 0; $k < $nkpoints; $k++) {
    for (my $i = 0; $i < $nions; $i++) {
        my $num = $i+1;
        print OUT "ion $num $kpointinfo->[0][$k]\n"; 
        for (my $spin = 0; $spin < $nspins; $spin++) {
            print OUT " " if ($spin == 1);
            print OUT "energy occ s p d tot";
        }
        print OUT "\n";
        for (my $b = 0; $b < $nbands; $b++) {
            for (my $spin = 0; $spin < $nspins; $spin++) {
                print OUT " " if ($spin == 1);
                print OUT "$energy->[$spin][0][$b] $occ->[$spin][0][$b] ";
                print OUT "$data->[$spin][0][$b][$i]{'s'} ";
                print OUT "$data->[$spin][0][$b][$i]{'p'} ";
                print OUT "$data->[$spin][0][$b][$i]{'d'} ";
                print OUT "$data->[$spin][0][$b][$i]{'tot'}";
            }
            print OUT "\n";
        }
    }
}

close(OUT);
