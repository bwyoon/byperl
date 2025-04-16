#!/usr/bin/perl


if (scalar(@ARGV) < 1) {
    print stderr "USAGE: addjobfromhere.pl jobid\n";
    exit(1)
}
my $curdir = `pwd`;
chomp($curdir);
`echo $ARGV[0] $curdir >> ~/mymsubjobs`;
print "$ARGV[0] $curdir\n";

