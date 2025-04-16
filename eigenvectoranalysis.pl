#!/usr/bin/perl

# eigenvector file name from command line argument
my $evfile = $ARGV[0];

if ($evfile !~ /eigenvectors\.txt/) {
    print stderr "invalid file.\n";
    exit(1);
}

# POSCAR and results.txt files 
(my $posfile = $evfile) =~ s/eigenvectors\.txt$/POSCAR/;
(my $resfile = $evfile) =~ s/eigenvectors\.txt$/results\.txt/;
(my $tokfile = $evfile) =~ s/eigenvectors\.txt$/token\.res/;

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
    $atominfo->{'elem'}[$n]   = $v[0];
    $atominfo->{'pos'}[$n][0] = $v[1];
    $atominfo->{'pos'}[$n][1] = $v[2];
    $atominfo->{'pos'}[$n][2] = $v[3];
    $atominfo->{'molecule'}[$n] = "";
} 
close($fi);

my $count = 0;

# molecule info
# search CH4 molecules
my $matoms = 5;
my @lines = `molfindmolecule $posfile $matoms "C H H H H" "1 1 1 1 1" "1.2 1.2 1.2 1.2 1.2"`;
my $nmolecules = scalar(@lines);
for (my $n = 0; $n < $nmolecules; $n++) {
    my $line = $lines[$n];
    chomp($line);
    my @v = split(" ", $line);
    # if it is not tagged, tag the atoms of molecules
    if ($atominfo->{'molecule'}[$v[0]-1] eq "") {
        $count++;
        my $moltag = "CH4_$count";
        for ($m = 0; $m < $matoms; $m++) {
            $atominfo->{'molecule'}[$v[$m]-1] = $moltag; 
        } 
    }
}

# search CH3 molecules
my $matoms = 4;
my @lines = `molfindmolecule $posfile $matoms "C H H H" "1 1 1 1" "1.2 1.2 1.2 1.2"`;
my $nmolecules = scalar(@lines);
$count = 0;
for (my $n = 1; $n <= $nmolecules; $n++) {
    my $line = $lines[$n-1];
    chomp($line);
    my @v = split(" ", $line);
    # if it is not tagged, tag the atoms of molecules
    if ($atominfo->{'molecule'}[$v[0]-1] eq "") {
        $count++;
        my $moltag = "CH3_$count";
        for ($m = 0; $m < $matoms; $m++) {
            $atominfo->{'molecule'}[$v[$m]-1] = $moltag; 
        } 
    }
}

# search CH2O molecules
my $matoms = 4;
my @lines = `molfindmolecule $posfile $matoms "C H H O" "1 1 1 1" "1.2 1.2 1.2 1.4"`;
my $nmolecules = scalar(@lines);
$count = 0;
for (my $n = 1; $n <= $nmolecules; $n++) {
    my $line = $lines[$n-1];
    chomp($line);
    my @v = split(" ", $line);
    # if it is not tagged, tag the atoms of molecules
    if ($atominfo->{'molecule'}[$v[0]-1] eq "") {
        $count++;
        my $moltag = "CH2O_$count";
        for ($m = 0; $m < $matoms; $m++) {
            $atominfo->{'molecule'}[$v[$m]-1] = $moltag; 
        } 
    }
}

# search CH2 molecules
my $matoms = 3;
my @lines = `molfindmolecule $posfile $matoms "C H H" "1 1 1" "1.2 1.2 1.2"`;
my $nmolecules = scalar(@lines);
$count = 0;
for (my $n = 1; $n <= $nmolecules; $n++) {
    my $line = $lines[$n-1];
    chomp($line);
    my @v = split(" ", $line);
    # if it is not tagged, tag the atoms of molecules
    if ($atominfo->{'molecule'}[$v[0]-1] eq "") {
        $count++;
        my $moltag = "CH2_$count";
        for ($m = 0; $m < $matoms; $m++) {
            $atominfo->{'molecule'}[$v[$m]-1] = $moltag; 
        } 
    }
}

# search HO2 molecules
my $matoms = 3;
my @lines = `molfindmolecule $posfile $matoms "H O O" "1 1 1" "1.2 1.2 1.5"`;
my $nmolecules = scalar(@lines);
$count = 0;
for (my $n = 1; $n <= $nmolecules; $n++) {
    my $line = $lines[$n-1];
    chomp($line);
    my @v = split(" ", $line);
    # if it is not tagged, tag the atoms of molecules
    if ($atominfo->{'molecule'}[$v[0]-1] eq "") {
        $count++;
        my $moltag = "HO2_$count";
        for ($m = 0; $m < $matoms; $m++) {
            $atominfo->{'molecule'}[$v[$m]-1] = $moltag; 
        } 
    }
}

# search O2 molecules
my $matoms = 2;
my @lines = `molfindmolecule $posfile $matoms "O O" "1 1" "1.5 1.5"`;
my $nmolecules = scalar(@lines);
$count = 0;
for (my $n = 1; $n <= $nmolecules; $n++) {
    my $line = $lines[$n-1];
    chomp($line);
    my @v = split(" ", $line);
    # if it is not tagged, tag the atoms of molecules
    if ($atominfo->{'molecule'}[$v[0]-1] eq "") {
        $count++;
        my $moltag = "O2_$count";
        for ($m = 0; $m < $matoms; $m++) {
            $atominfo->{'molecule'}[$v[$m]-1] = $moltag; 
        } 
    }
}


# search H2O2 molecules
my $matoms = 4;
my @lines = `molfindmolecule $posfile $matoms "H O O H" "1 1 2 3" "1.2 1.2 1.6 1.2"`;
my $nmolecules = scalar(@lines);
$count = 0;
for (my $n = 1; $n <= $nmolecules; $n++) {
    my $line = $lines[$n-1];
    chomp($line);
    my @v = split(" ", $line);
    # if it is not tagged, tag the atoms of molecules
    if ($atominfo->{'molecule'}[$v[0]-1] eq "") {
        $count++;
        my $moltag = "H2O2_$count";
        for ($m = 0; $m < $matoms; $m++) {
            $atominfo->{'molecule'}[$v[$m]-1] = $moltag; 
        } 
    }
}

# search HO2 molecules
my $matoms = 3;
my @lines = `molfindmolecule $posfile $matoms "H O O" "1 1 2" "1.2 1.2 1.6"`;
my $nmolecules = scalar(@lines);
$count = 0;
for (my $n = 1; $n <= $nmolecules; $n++) {
    my $line = $lines[$n-1];
    chomp($line);
    my @v = split(" ", $line);
    # if it is not tagged, tag the atoms of molecules
    if ($atominfo->{'molecule'}[$v[0]-1] eq "") {
        $count++;
        my $moltag = "HO2_$count";
        for ($m = 0; $m < $matoms; $m++) {
            $atominfo->{'molecule'}[$v[$m]-1] = $moltag; 
        } 
    }
}

# search H2O molecules
my $matoms = 3;
my @lines = `molfindmolecule $posfile $matoms "O H H" "1 1 1" "1.2 1.2 1.2"`;
my $nmolecules = scalar(@lines);
$count = 0;
for (my $n = 1; $n <= $nmolecules; $n++) {
    my $line = $lines[$n-1];
    chomp($line);
    my @v = split(" ", $line);
    # if it is not tagged, tag the atoms of molecules
    if ($atominfo->{'molecule'}[$v[0]-1] eq "") {
        $count++;
        my $moltag = "H2O_$count";
        for ($m = 0; $m < $matoms; $m++) {
            $atominfo->{'molecule'}[$v[$m]-1] = $moltag; 
        } 
    }
}

# search HO molecules
my $matoms = 2;
my @lines = `molfindmolecule $posfile $matoms "O H" "1 1" "1.2 1.2"`;
my $nmolecules = scalar(@lines);
$count = 0;
for (my $n = 1; $n <= $nmolecules; $n++) {
    my $line = $lines[$n-1];
    chomp($line);
    my @v = split(" ", $line);
    # if it is not tagged, tag the atoms of molecules
    if ($atominfo->{'molecule'}[$v[0]-1] eq "") {
        $count++;
        my $moltag = "HO_$count";
        for ($m = 0; $m < $matoms; $m++) {
            $atominfo->{'molecule'}[$v[$m]-1] = $moltag; 
        } 
    }
}

# search Au2H molecules
my $matoms = 3;
my @lines = `molfindmolecule $posfile $matoms "H Au Au" "1 1 1" "1.2 2.0 2.0"`;
my $nmolecules = scalar(@lines);
$count = 0;
for (my $n = 1; $n <= $nmolecules; $n++) {
    my $line = $lines[$n-1];
    chomp($line);
    my @v = split(" ", $line);
    # if it is not tagged, tag the atoms of molecules
    if ($atominfo->{'molecule'}[$v[0]-1] eq "") {
        $count++;
        my $moltag = "Au2H_$count";
        for ($m = 0; $m < $matoms; $m++) {
            $atominfo->{'molecule'}[$v[$m]-1] = $moltag; 
        } 
    }
}

# search AuH molecules
my $matoms = 2;
my @lines = `molfindmolecule $posfile $matoms "H Au" "1 1" "1.2 1.9"`;
my $nmolecules = scalar(@lines);
$count = 0;
for (my $n = 1; $n <= $nmolecules; $n++) {
    my $line = $lines[$n-1];
    chomp($line);
    my @v = split(" ", $line);
    # if it is not tagged, tag the atoms of molecules
    if ($atominfo->{'molecule'}[$v[0]-1] eq "") {
        $count++;
        my $moltag = "AuH_$count";
        for ($m = 0; $m < $matoms; $m++) {
            $atominfo->{'molecule'}[$v[$m]-1] = $moltag; 
        } 
    }
}

# search Au2O molecules
my $matoms = 3;
my @lines = `molfindmolecule $posfile $matoms "O Au Au" "1 1 1" "1.2 2.0 2.0"`;
my $nmolecules = scalar(@lines);
$count = 0;
for (my $n = 1; $n <= $nmolecules; $n++) {
    my $line = $lines[$n-1];
    chomp($line);
    my @v = split(" ", $line);
    # if it is not tagged, tag the atoms of molecules
    if ($atominfo->{'molecule'}[$v[0]-1] eq "") {
        $count++;
        my $moltag = "Au2O_$count";
        for ($m = 0; $m < $matoms; $m++) {
            $atominfo->{'molecule'}[$v[$m]-1] = $moltag; 
        } 
    }
}

# search AuO molecules
my $matoms = 2;
my @lines = `molfindmolecule $posfile $matoms "O Au" "1 1" "1.2 2.0"`;
my $nmolecules = scalar(@lines);
$count = 0;
for (my $n = 1; $n <= $nmolecules; $n++) {
    my $line = $lines[$n-1];
    chomp($line);
    my @v = split(" ", $line);
    # if it is not tagged, tag the atoms of molecules
    if ($atominfo->{'molecule'}[$v[0]-1] eq "") {
        $count++;
        my $moltag = "AuO_$count";
        for ($m = 0; $m < $matoms; $m++) {
            $atominfo->{'molecule'}[$v[$m]-1] = $moltag; 
        } 
    }
}

for (my $n = 0; $n < $natoms; $n++) {
    if ($atominfo->{'molecule'}[$n] eq "") {
        $atominfo->{'molecule'}[$n] = $atominfo->{'elem'}[$n];
    }
}

for (my $n = 0; $n < $natoms; $n++) {
    print "$atominfo->{'elem'}[$n] $atominfo->{'molecule'}[$n]\n";
}

# read eigenvectors.txt
my $vibinfo;
my $nvibs = 3*$natoms;
$vibinfo->{'vibcount'} = $nvibs;
open(my $fi, "<", $evfile);
<$fi>; <$fi>; <$fi>; <$fi>;
for (my $n = 0; $n < $nvibs; $n++) {
    $line = <$fi>; chomp($line);
    ($vibinfo->{'freq'}[$n] = $line) =~ s/.+2PiTHz(.+)cm-1.+/\1/;
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
            $v[$m] += ($vibinfo->{'eigenvector'}[$n][$m][$k])**2.0; 
        }
        $v[$m] = sqrt($v[$m]);
    }
    # sorting in descending order
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


# write token results
open(my $fout, ">", $tokfile);
#print " $atominfo->{'atomcount'}\n";
#for (my $n = 0; $n < $natoms; $n++) {
#    print " $atominfo->{'elem'}[$n]";
#    print " $atominfo->{'pos'}[$n][0]";
#    print " $atominfo->{'pos'}[$n][1]";
#    print " $atominfo->{'pos'}[$n][2]\n";
#} 
#print "$vibinfo->{'vibcount'} \n";
for (my $n = 0; $n < $nvibs; $n++) {
    $nn = $n+1;
    print $fout  " $nn";
    print $fout " $vibinfo->{'freq'}[$n]";
    print $fout " $vibinfo->{'intensity'}[$n]";
    print $fout " $vibinfo->{'eigenvectortoken'}[$n]\n";
}

close($fout);

# print "$posfile\n";


