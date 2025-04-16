#!/usr/bin/perl


if (scalar(@ARGV) < 1) {
    print stderr "USAGE: removejob.pl jobid [ jobid2 ... ]\n";
    exit(1)
}

for (@ARGV) {
    `sed -i -r '/^$_/d' ~/mymsubjobs`;
}

