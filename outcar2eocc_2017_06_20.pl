#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

my @argv = @ARGV;
my $argc = @argv;

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
my @lines = <IN>;
close(IN);

my @val;
my $val;
my $nband;
my $ox = 0;
my $count;
my @e;
my @o;

for (@lines) {
    if (/NELECT/) {
        @val = split(" ");
        $val = $val[2]/2;
        print "HOMO $val\n";
        last;
    }
}

for (@lines) {
    if ($ox == 0) {
        if (/NBANDS/) {
            ($nband = $_) =~ s/^.+NBANDS=\s*([^ ]+)\s+$/\1/;
            next;
        }
        $ox = 1 if (/^  band No.  band/);
    } else {
        ($val, $e[++$count], $o[$count]) = split(" ");
        $ox = $count = 0 if ($count == $nband);
    }
}

for (my $n = 1; $n <= $nband; $n++) {
    print "$n $e[$n] $o[$n]\n";
}

