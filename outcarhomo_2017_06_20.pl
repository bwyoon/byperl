#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

my @argv = @ARGV;
my $argc = @argv;
my @val;
my $val;

if ($argc == 1) {
    $fn = $argv[0];
} else {
    if (-e "converged.OUTCAR") {
        $fn = "converged.OUTCAR";
    } elsif (-e "optimized.OUTCAR") {
        $fn = "optimized.OUTCAR";
    } else {
        $fn = "OUTCAR";
    }
}
if (! -e $fn) {
   print STDERR "$fn not found.\n";
   exit(1);
}

open(IN, "<$fn");
while (<IN>) {
    if ($_ =~ /NELECT/) {
        @val = split(" ", $_);
        $val = $val[2]/2;
        print "$val\n";
        last;
    }
}
close(IN);


