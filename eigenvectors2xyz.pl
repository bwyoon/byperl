#!/usr/bin/perl

if (scalar(@ARGV) < 1) {
    print stderr "USAGE: eigenvectors2xyz.pl eigenvectorfile\n";
    exit(1);
}

chomp $ARGV[0];
my $evfile = $ARGV[0];
my $posfile = $ARGV[0];
(my $posfile = $evfile) =~ s/eigenvectors\.txt/POSCAR/;

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
} 
close($fi);

# read eigenvectors.txt
my $vibinfo;
my $nvibs = 3*$natoms;
open(my $fi, "<", $evfile);
<$fi>; <$fi>; <$fi>; <$fi>;
for (my $n = 1; $n <= $nvibs; $n++) {

    (my $xyzfile = $posfile) =~ s/POSCAR$/$n\.xyz/;

    open(my $fout, ">", $xyzfile);
    print $fout "$natoms\n";

    $line = <$fi>; chomp($line);
    print $fout "$line\n";

    <$fi>;
    for (my $m = 0; $m < $natoms; $m++) {
        $line = <$fi>; chomp($line);
        print $fout "$atominfo->{'elem'}[$m] $line\n";
    } 
    <$fi>;

    close($fout);
}
close($fi);

