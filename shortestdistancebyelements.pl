#!/usr/bin/perl

$argc = scalar(@ARGV);

my %dist;

for (my $n = 0; $n < $argc; $n++) {
# or for $x (@ARGV) {
  $x = $ARGV[$n];
  $line = `molfindnear optimized.POSCAR $x 3.8 | shortestdistancebyelement.sh`;
  my @lines = split(/\n/,  $line);
  for $line (@lines) { 
    my @v = split(/\s+/, $line);
    # print("@v\n");
    if (exists $dist{$v[0]}) {
      $dist{$v[0]} = "$dist{$v[0]} $v[1]";
    } else {
      $dist{$v[0]} = "$v[1]";
    }
  }
}

foreach my $k (keys %dist) {
  my @v = split(/ /, $dist{$k});
  my $vsum = 0.0;
  for my $x (@v) {
    $vsum += $x;
  }
  $vsum /= scalar(@v);
  print("$k: $dist{$k} : $vsum\n"); 
}
