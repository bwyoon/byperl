#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::Element;

my $r;
for (my $n = 1; $n <= 100; $n++) {
    $r = BY::Element::GetCovalentRadius($n);
    print "$r,";
    print "\n" if ($n%10 == 0);
}

