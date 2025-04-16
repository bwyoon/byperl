#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use OUTCAR;

my $fn = OUTCAR::getOUTCARfilename(@ARGV);
if ($fn eq "") {
   print STDERR "$fn not found.\n";
   exit(1);
}



my @argv = @ARGV;
my $argc = @argv;
my @lines;
my $count, $i, $j, $k;
my @val;
my $lv;

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
@lines = <IN>;
close(IN);

$count = @lines;

for ($i = 0; $i < $count; $i++) {
    if ($lines[$i] =~ /direct lattice vectors/) {
        for ($j = 0; $j < 3; $j++) {
            $i++;
            @val = split(" ", $lines[$i]);
            for ($k = 0; $k < 3; $k++) {
                $lv->[$j][$k] = $val[$k];
            }
        }
    } 
}
        
print "$lv->[0][0] $lv->[0][1] $lv->[0][2]\n";
print "$lv->[1][0] $lv->[1][1] $lv->[1][2]\n";
print "$lv->[2][0] $lv->[2][1] $lv->[2][2]\n";

