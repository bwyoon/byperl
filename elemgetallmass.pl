#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::Element;

my $mass;
for (my $n = 1; $n <= 100; $n++) {
    $mass = BY::Element::GetAtomicMass($n);
    print "$mass,";
    print "\n" if ($n%10 == 0);
}

