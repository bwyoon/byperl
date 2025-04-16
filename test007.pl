#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

$var = 10;
$r = \$var;
print "Value of $var is ", $$r, "\n";
print "Reference type if r is ", ref($r), "\n";

@var = (1,2,3);
$r = \@var;
print "Value of @var is ", @$r, "\n";
print "Reference type if r is ", ref($r), "\n";

%var = ('key1'=> 10, 'key2'=>20);
$r = \%var;
print "Value of %var is ", %$r, "\n";
print "Reference type if r is ", ref($r), "\n";


sub PrintHash 
{
    my %hash = @_;

    foreach $item (%hash) {
        print "Item : $item\n";
    }

}

$sref = \&PrintHash;

%hash = ('name'=> 'Tom', 'age'=>19);

&$sref(%hash);

