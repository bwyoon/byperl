#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

my @argv = @ARGV;
my $argc = @argv;
my @lines;
my @val;
my $count;
my @res;

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

@val = grep(/^  in kB/, @lines);
$count = @val;
@res = split(" ", $val[$count-1]);

print "$res[2] $res[3] $res[4] $res[5] $res[6] $res[7]\n";



#while (<IN>) {
    if ($_ =~ /^  in kB/) {
#        $_ =~ s/^.+NBANDS=\s*([^ ]+)\s+$/\1/;
#        print "$_\n";
#        last;
#    }
}


