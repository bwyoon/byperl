#!/usr/bin/perl

my $res = `ls *.POSCAR`;
my @files = split(' ', $res);
my $poscarfile;
for (@files) {
    $poscarfile = $_;
    my $ocount = `molelemcount $_ O`;
    if (/o2/i) {
        if ($_ !~ /robert_ir/) {
            chomp $ocount;
            if ($ocount == 2) {
                my $line = `molelemindex $_ O`;
                my @vals = split(" ", $line);
                my $bloo = `molbl $_ $vals[0] $vals[1]`;
                chomp($bloo);
                my $vibfreq;
                if ($bloo < 2.0) {
                    my $resfile = $_;
                    $resfile =~ s/POSCAR/results.txt/;
                    open(my $fi, "<", $resfile);
                    while (<$fi>) {
                        my @vals = split " ";
                        if ($vals[1] < 1600.0) {
                            $vibfreq = $vals[1];
                            last;
                        } 
                    }
                    close($fi);
                    print "$bloo $vibfreq $poscarfile\n";
                }
            }
        }
    }
}
# print $files;


