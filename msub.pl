#!/usr/bin/perl

if (scalar(@ARGV) != 1) {
    print stderr "USAGE msub.pl msubscript\n";
    exit(1);
}

my $curdir = `pwd`;
chomp($curdir);
my $line = `msub $ARGV[0]`;
my @lines = split("\n", $line);
my @vals = $lines[1];
if (scalar(@vals) != 1) {
    print stderr "msub failed.\n";
    exit(1);
}
$jobnum = $vals[0];
chomp($jobnum);

`echo $jobnum $curdir >> ~/mymsubjobs`;
print "$jobnum $curdir\n";
