#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

@days = qw/Monday Tuesday Wednesday Thursday Friday Saturday Sunday/;

print "@days\n";

print "after push:\n";
push @days, "anyday";
print "@days\n";

print "after pop:\n";
pop @days;
print "@days\n";

print "after shift:\n";
shift @days;
print "@days\n";

print "after unshift:\n";
unshift @days, "Monday";
print "@days\n";

print "weekdays:\n";
@weekdays=@days[0..4];
print "@weekdays\n";

print "after splice:\n";
splice @days, 1, 2, ("tuesday", "ednesday");
print "@days\n";
