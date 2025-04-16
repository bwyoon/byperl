#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

$daystring="Monday  Tuesday Wednesday Thursday Friday Saturday Sunday";
@days=split(' ', $daystring);

$count = @days;

print "count: $count\n";

print "after sort:\n";
@days=sort(@days);
print "@days\n";

@days2=qw(Monday  Tuesday Wednesday Thursday Friday Saturday Sunday);
print "@days2\n";

