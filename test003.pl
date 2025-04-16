#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

%data=('John Paul', 45, 'Lisa Calorie', 30, 'Kumar Vijay', 40);

print "$data{'John Paul'}\n";

@keys=keys %data;
print "@keys\n";

@values=values %data;
print "@values\n";

print "after add hash element:\n";
$data{'Bokwon Yoon'} = 49;
@keys = keys %data;
print "@keys\n";
@values = values %data;
print "@values\n";

print "after delete hash element:\n";
delete $data{'Lisa Calorie'};
@keys = keys %data;
print "@keys\n";
@values = values %data;
print "@values\n";
