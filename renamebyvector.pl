#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

my @lines = `ls byvector*.pl`;
my $fn;
for (@lines) {
    chomp;
    ($fn = $_) =~ s/byvector/vector/;
    my $cmd = "mv $_ $fn";
    `$cmd`;
}
