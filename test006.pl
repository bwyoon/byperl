#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

sub average
{
    $n = scalar(@_);

    $sum = 0;
    foreach $item (@_) {
        $sum += $item;
    }

    print "$sum\n";
}

average(10, 20, 30, 40, 50);

sub PrintList{
    my @list = @_;
    print "@list\n";
}

$a = 10;
@b = (1,2,3,4,5);

PrintList($a, @b);

sub PrintHash {
    my %hash = @_;

    foreach $key (keys %hash) {
        print "$key => $hash{$key}\n";  
    }
}

%data=('name'=>'Bokwon Yoon', 'age'=>49);

PrintHash(%data);
