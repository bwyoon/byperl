#!/usr/bin/perl

my $line = `ls *.eigenvectors.txt`;
my @evfiles = split(' ', $line);
my %mass = ("Au" => 196.9666, "C" => 12.0107, "O" => 15.9994, "H" => 2.0);

for (@evfiles) {
    chomp;
    my $line = `./eigenvectoranalysis.pl $_`;
    print "$line";
    last;
}


