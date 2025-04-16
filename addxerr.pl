#!/usr/bin/perl


if (scalar(@ARGV) < 3) {
    print stderr "USAGE addxerr.pl e.dat veff.dat l\n";
    exit(1);
}

my $L = $ARGV[2];
chomp($L);
#print "$L\n";

my $Veff;
open(my $fi, "<", $ARGV[1]);
<$fi>;
my $count = 0;
while (<$fi>) {
    chomp;
    my @v = split(" ");
    $Veff->{'r'}[$count] = $v[0];    
    $Veff->{'Veff'}[0][$count] = $v[1];    
    $Veff->{'Veff'}[1][$count] = $v[2];    
    $Veff->{'Veff'}[2][$count] = $v[3];    
    $Veff->{'Veff'}[3][$count] = $v[4];    
    $Veff->{'Veff'}[4][$count] = $v[5];    
    #print "$Veff->{'r'}[$count] $Veff->{'Veff'}[0][$count]\n";
    $count++;
}
close($fi);


open($fi, "<", $ARGV[0]);
while (<$fi>) {
    chomp;
    my @v = split(" ");
    my $E = $v[0];
    my ($rprev, $r, $vprev, $v);
    my $ri = $Veff->{'r'}[0];
    my $rf = $Veff->{'r'}[$count-1];
    $rprev = $Veff->{'r'}[0];
    $vprev = $Veff->{'Veff'}[$L][0];
    for (my $n = 1; $n < $count; $n++) {
        $r = $Veff->{'r'}[$n];
        $v = $Veff->{'Veff'}[$L][$n];
        if (($vprev > $E) && ($v <= $E)) {
            $ri = $rprev + ($r-$rprev)*($E-$vprev)/($v-$vprev) 
        } 
        if (($vprev < $E) && ($v >= $E)) {
            $rf = $rprev + ($r-$rprev)*($E-$vprev)/($v-$vprev) 
        } 
        $vprev = $v;
        $rprev = $r;
    }
    $r = 0.5*($ri+$rf);
    my $dr = 0.5*($rf-$ri);
    print "$E $r $dr\n"; 
}
close($fi);

