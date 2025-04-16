#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

my $line = `ls OUTCAR*.pl`;

my @files = split(" ", $line);
my $filecount = scalar @files;

for (@files) {
    my $fnb = $_;
    $fnb =~ s/OUTCAR/outcar/;
    `mv $_ $fnb\n`;
}
