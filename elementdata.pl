#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

my $mainurl = 'https://www.webelements.com';

my @lines = `curl -D /dev/null -o - -k -s $mainurl`;
my $n = 0;
my @urls;
for (@lines) {
    if (/<a class="sym" href="([^"]+)"/) {
        $urls[$n++] =  "$mainurl/$1";
    }
}

print "N symbol name m Rcovalent Rvdw Tm Tb structure a b c alpha beta gamma\n";
for (@urls) {
    my $line = `curl -D /dev/null -o - -k -s $_`;
    my $name = $1 if ($line =~ m%Name[^:]*:\s*([a-zA-Z]+)%);
    my $symbol = $1 if ($line =~ m%Symbol[^:]*:\s*([a-zA-Z]+)%);
    my $atomicnumber = $1 if ($line =~m%Atomic number[^:]*:\s*([0-9]+)%);
    my $atomicmass = $1 if ($line =~ m%Relative atomic mass[^:]*:[ \[]*([0-9.]+)%);
    my $melting = "nodata";
    $melting = $1 if ($line =~ m%Melting point[^:]*:\s*([0-9.]+)%);
    my $boiling = "nodata";
    $boiling = $1 if ($line =~ m%Boiling point[^:]*:\s*([0-9.]+)%);

    $line = `curl -D /dev/null -o - -k -s $_/atom_sizes.html`;
    my $covalentradius = "nodata";
    $covalentradius = $1/100.0 if ($line =~ m%">Covalent radius.+\n.*<td>([0-9]+)%);
    my $vdwradius = "nodata";
    $vdwradius = $1/100.0 if ($line =~ m%">van der Waals.+\n.*<td>([0-9]+)%);

    $line = `curl -D /dev/null -o - -k -s $_/crystal_structure.html`;
    my $structure = "nodata";
    $structure = $1 if ($line =~ m%<li>Structure: <strong>([a-zA-Z]+)%);
    my $cpa = "nodata";
    $cpa = $1/100.0 if ($line =~ m%<em>a</em>: ([ 0-9]+)%);
    my $cpb = "nodata";
    $cpb = $1/100.0 if ($line =~ m%<em>b</em>: ([ 0-9]+)%);
    my $cpc = "nodata";
    $cpc = $1/100.0 if ($line =~ m%<em>c</em>: ([ 0-9]+)%);
    my $cpalpha = "nodata";
    $cpalpha = $1 if ($line =~ m%&alpha;: ([ 0-9]+)%);
    my $cpbeta  = "nodata";
    $cpbeta  = $1 if ($line =~ m%&beta;: ([ 0-9]+)%);
    my $cpgamma = "nodata";
    $cpgamma = $1 if ($line =~ m%&gamma;: ([ 0-9]+)%);
   
    print "$atomicnumber $symbol $name $atomicmass $covalentradius $vdwradius $melting $boiling $structure $cpa $cpb $cpc $cpalpha $cpbeta $cpgamma\n";
}

