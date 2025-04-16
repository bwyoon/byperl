#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

my $line = `ls outcar*.pl`;

my @files = split(" ", $line);
my $filecount = scalar @files;

for (@files) {
    my $fnb = lc $_;
    `mv $_ $fnb`;
}
