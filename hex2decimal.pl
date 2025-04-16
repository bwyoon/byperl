#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################


if (scalar(@ARGV) < 1) {
    print STDERR "USAGE: hex2decimal.pl FFFF\n";
    exit(1);      
}

$num = hex($ARGV[0]);
print "$num\n";
