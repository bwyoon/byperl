#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################


if (scalar(@ARGV) < 1) {
    print STDERR "USAGE: decimal2hex.pl 255\n";
    exit(1);      
}

$num = sprintf("%X", $ARGV[0]);
print "$num\n";
