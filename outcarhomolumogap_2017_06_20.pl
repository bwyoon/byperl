#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

my @argv = @ARGV;
my $argc = @argv;
my @val, @valb;
my $homo, $lumo, $ehomo, $elumoi, $e;
my $count;

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
    if ($lines[$i] =~ /NELECT/) {
        @val = split(" ", $lines[$i]);
        $homo = $val[2]/2;
        last;
    }
} 

@val = grep  /^\s+$homo/, @lines;
$count = @val;
@valb = split(" ", $val[$count-1]);
$ehomo = $valb[1];

$lumo = $homo+1;
@val = grep  /^\s+$lumo/, @lines;
$count = @val;
@valb = split(" ", $val[$count-1]);
$elumo = $valb[1];

$e = $elumo-$ehomo;

print "$e\n";


