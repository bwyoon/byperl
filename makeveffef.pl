#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

if (scalar(@ARGV) < 6) {
    print STDERR "USAGE: makeveffef.pl infile outfile zbot ztop zmax EF\n";
    exit(1);
}

my $zbot = $ARGV[2];
my $ztop = $ARGV[3];
my $zmax = $ARGV[4];
my $ef   = $ARGV[5];
my $tmpfn = "tmp.dat";

open(my $fin, "<", $ARGV[0]);
open(my $fout, ">", $tmpfn); 

my $line = <$fin>;
print $fout "z Veff-EF\n";

my @lines = <$fin>;

for (@lines) {
    chomp;
    my @vals = split;
    $vals[0] -= $ztop;
    $vals[0] += $zmax if ($vals[0] < -($ztop-$zbot));
    $vals[1] -= $ef;
    $_ = join(" ", @vals);
    print $fout "$_\n";
}

close($fin);
close($fout);

#`mv $tmpfn $ARGV[1]`;
`sort -k1g < $tmpfn > $ARGV[1]`;
`rm $tmpfn`;
