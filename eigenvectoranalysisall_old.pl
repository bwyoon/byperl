#!/usr/bin/perl

my $line = `ls *.eigenvectors.txt`;
my @evfiles = split(' ', $line);
my %mass = ("Au" => 196.9666, "C" => 12.0107, "O" => 15.9994, "H" => 2.0);

for (@evfiles) {
    chomp;

    my $evfile = $_;
    (my $posfile = $_) =~ s/eigenvectors.txt$/POSCAR/;
    (my $resfile = $_) =~ s/eigenvectors.txt$/results.txt/;

    # read POSCAR file
    my $atominfo;
    `mol2xyz $posfile tmp.xyz`;
    open(my $fi, "<", "tmp.xyz");
    my @v = split(" ", <$fi>);
    my $natoms = $v[0]; chomp($natoms);
    $atominfo->{'atomcount'} = $natoms;
    $line = <$fi>;
    for (my $n = 0; $n < $natoms; $n++) {
        my @v = split(" ", <$fi>); chomp($v[3]);
        $atominfo->{'elem'}[$n] = $v[0];
        $atominfo->{'pos'}[$n][0] = $v[1];
        $atominfo->{'pos'}[$n][1] = $v[2];
        $atominfo->{'pos'}[$n][2] = $v[3];
    } 
    close($fi);

    # read eigenvectors.txt
    my $vibinfo;
    my $nvibs = 3*$natoms;
    $vibinfo->{'vibcount'} = $nvibs;
    open(my $fi, "<", $evfile);
    <$fi>; <$fi>; <$fi>; <$fi>;
    for (my $n = 0; $n < $nvibs; $n++) {
        $line = <$fi>; chomp($line);
        $line =~ s/.+2PiTHz(.+)cm-1.+/\1/;
        $vibinfo->{'freq'}[$n] = $line;
        <$fi>;
        for (my $m = 0; $m < $natoms; $m++) {
            $line = <$fi>; chomp($line);
            my @v = split(" ", $line);
            $vibinfo->{'eigenvector'}[$n][$m][0] = $v[3];
            $vibinfo->{'eigenvector'}[$n][$m][1] = $v[4];
            $vibinfo->{'eigenvector'}[$n][$m][2] = $v[5];
        } 
        <$fi>;
    }
    close($fi);

    # eigenvector to token conversion
    for (my $n = 0; $n < $nvibs; $n++) {
        my @v;
        for (my $m = 0; $m < $natoms; $m++) {
            $v[$m] = 0.0;
            for (my $k = 0; $k < 3; $k++) {
                # $v[$m] += ($vibinfo->{'eigenvector'}[$n][$m][$k])**2.0*$mass{$atominfo->{'elem'}[$m]}**2.0; 
                $v[$m] += ($vibinfo->{'eigenvector'}[$n][$m][$k])**2.0; 
            }
            $v[$m] = sqrt($v[$m]);
        }
        my @ind;
        for (my $m = 0; $m < $natoms; $m++) {
            $ind[$m] = $m;
        }
        for (my $m = 0; $m < $natoms-1; $m++) {
            for (my $l = $m+1; $l < $natoms; $l++) {
                if ($v[$ind[$l]] > $v[$ind[$m]]) {
                     my $buf = $ind[$m];
                     $ind[$m] = $ind[$l];
                     $ind[$l] = $buf;
                }
            }
        }
        my @ox = 0 x $natoms;
        $ox[$ind[0]] = 1;
        $ox[$ind[1]] = 1;
        for (my $m = 2; $m < $natoms; $m++) {
            last if ($v[$ind[$m]] < 0.5*$v[$ind[$m-1]]);
            $ox[$ind[$m]] = 1;
        }
   
        my $token = '';
        for (my $m = 0; $m < $natoms; $m++) {
            $token .= $atominfo->{'elem'}[$m] if ($ox[$m] == 1);
        }
        # my $token = $atominfo->{'elem'}[$ind[0]];
        # $token .= $atominfo->{'elem'}[$ind[1]];
        # for (my $m = 2; $m < $natoms; $m++) {
        #     last if ($v[$ind[$m]] < 0.5*$v[$ind[$m-1]]);
        #     $token .= $atominfo->{'elem'}[$ind[$m]];
        # }
        $vibinfo->{'eigenvectortoken'}[$n] = $token;
    }

    # read results.txt
    open(my $fi, "<", $resfile);
    for (my $n = 0; $n < $nvibs; $n++) {
        $line = <$fi>; chomp($line);
        my @v = split(" ",  $line);
        chomp($v[2]);
        $vibinfo->{'intensity'}[$n] = $v[2];
    }
    close($fi);


    # check reading results
    print " $atominfo->{'atomcount'}\n";
    for (my $n = 0; $n < $natoms; $n++) {
        print " $atominfo->{'elem'}[$n]";
        print " $atominfo->{'pos'}[$n][0]";
        print " $atominfo->{'pos'}[$n][1]";
        print " $atominfo->{'pos'}[$n][2]\n";
    } 
    print "$vibinfo->{'vibcount'} \n";
    for (my $n = 0; $n < $nvibs; $n++) {
        $nn = $n+1;
        print " $nn";
        print " $vibinfo->{'freq'}[$n]";
        print " $vibinfo->{'eigenvectortoken'}[$n]";
        print " $vibinfo->{'intensity'}[$n] \n";
    } 

    print "$posfile\n";
    last;
}


