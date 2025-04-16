#!/usr/bin/perl

if (scalar(@ARGV) < 6) {
    print stderr "USAGE: bob2vasp org_dir dest_dir vaspref_dir Lx Ly Lz\n";
    exit(1);
}

if (-e $ARGV[1] and -d $ARGV[1]) {
    print stderr "$ARGV[1] already exists!\n";
    exit(1);
}

my $lx = $ARGV[3];
my $ly = $ARGV[4];
my $lz = $ARGV[5];
my $hx = $lx/2.0;
my $hy = $ly/2.0;
my $hz = $lz/2.0;

`mkdir $ARGV[1]`;
`cp $ARGV[0]/I_info $ARGV[1]/.`;
`cp $ARGV[2]/INCAR $ARGV[1]/.`;
`cp $ARGV[2]/POTCAR $ARGV[1]/.`;
`cp $ARGV[2]/msubvasp $ARGV[1]/.`;
my $curdir = `pwd`;
chdir $ARGV[1];
#`cd $ARGV[1]`;
`iinfo2xyz.sh I_info > tmp.xyz`;
`mol2poscar tmp.xyz tmp1.POSCAR`;
`mollvchange tmp1.POSCAR tmp2.POSCAR $lx 0 0 0 $ly 0 0 0 $lz`;
`molshift tmp2.POSCAR tmp1.POSCAR  $hx $hy $hz`;
`molshiftcm2cellcenter tmp1.POSCAR POSCAR`;
`poscar20`;
chdir $curdir;
#`cd $curdir`;

