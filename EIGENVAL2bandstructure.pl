#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################


if (scalar @ARGV < 1) {
    print STDERR "USAGE: $0 EIGENVAL\n"; 
    exit 1;
}

my $kcount, $bcount;

my $count = 0;

while (<>) {
  $count++;
  if ($count == 6) {
    chomp;
    my @vals = split(' ');
    $kcount = $vals[1];
    $bcount = $vals[2];
    last;
  }
}

print "total number of kpoints = $kcount\n";
print "total number of bands   = $bcount\n";

my $prevkline = '';
my $kline;
my $lcount = 0;

for (my $k = 0; $k < $kcount; $k++) {
  <>;
  $kline = <>;
  my @vals = split(' ', $kline);
  if (!($kline eq $prevkline)) {
    $lcount++; 
    print "$lcount $vals[0] $vals[1] $vals[2]";
  }
  for (my $b = 0; $b < $bcount; $b++) {
    my $line = <>;
    my @vals = split(' ', $line);
    if (!($kline eq $prevkline)) {
      print " $vals[1]";     
    }
  }
  if (!($kline eq $prevkline)) {
    print "\n";
  }
  $prevkline = $kline;
}

