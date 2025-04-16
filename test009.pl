#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

open(DATA, "<file.txt") or die "Couldn't open file file.txt, $!";

while (<DATA>) {
    print "$_";
}
