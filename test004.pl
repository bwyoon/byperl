#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

$a=10;

while ($a < 20) {
    if ($a == 15) {
        $a = $a+1;
        next;
    }
    print "value of a: $a\n";
    $a = $a+1;
}
