#!/usr/bin/perl

my $line = `cat ~/mymsubjobs`;
my @lines = split("\n", $line);
my $myjobs;
for (my $n = 0; $n < scalar(@lines); $n++) {
  @vals = split(" ", $lines[$n]);
  $myjobs->[$n]{'id'} = @vals[0];
  $myjobs->[$n]{'dir'} = @vals[1];
  if (scalar(@vals) == 2) {
    $myjobs->[$n]{'status'} = 'Running';
  } else {
    $myjobs->[$n]{'status'} = $val[2];
  }
}


my $line = `showq`;
my @lines = split("\n", $line);
my @jlist;
for (@lines) {
  if (/active jobs--/ .. /eligible jobs--/) {
     push(@jlist, $_);
  }
}

my $runningjobs;
for (my $n = 0; $n < scalar(@jlist)-8; $n++) {
  my @vals = split(" ", $jlist[$n+3]);
  $runningjobs->[$n]{'id'} = $vals[0];
  $runningjobs->[$n]{'user'} = $vals[1];
  $runningjobs->[$n]{'status'} = $vals[2];
  $runningjobs->[$n]{'cores'} = $vals[3];
}

@jlist = ();
for (@lines) {
  if (/eligible jobs--/ .. /blocked jobs--/) {
     push(@jlist, $_);
  }
}
my $idlejobs;
for (my $n = 0; $n < scalar(@jlist)-7; $n++) {
  my @vals = split(" ", $jlist[$n+3]);
  $idlejobs->[$n]{'id'} = $vals[0];
  $idlejobs->[$n]{'user'} = $vals[1];
  $idlejobs->[$n]{'status'} = $vals[2];
  $idlejobs->[$n]{'cores'} = $vals[3];
}

@jlist = ();
my $ox = 0;
for (@lines) {
  $ox = 1 if (/blocked jobs--/);
  if ($ox == 1)  {
     push(@jlist, $_);
     print "$_\n";
  }
}
my $blockedjobs;
for (my $n = 0; $n < scalar(@jlist)-7; $n++) {
  my @vals = split(" ", $jlist[$n+3]);
  $blockedjobs->[$n]{'id'} = $vals[0];
  $blockedjobs->[$n]{'user'} = $vals[1];
  $blockedjobs->[$n]{'status'} = $vals[2];
  $blockedjobs->[$n]{'cores'} = $vals[3];
}

`rm ~/mymsubjobs`;

for (my $n = 0; $n < scalar(@{$myjobs}); $n++) {
  $myjobs->[$n]{'status'} = 'Finished';
  for (my $m = 0; $m < scalar(@{$runningjobs}); $m++) {
    if ($myjobs->[$n]{'id'} == $runningjobs->[$m]{'id'}) {
      $myjobs->[$n]{'status'} = $runningjobs->[$m]{'status'};
      last;
    }
  }
  for (my $m = 0; $m < scalar(@{$idlejobs}); $m++) {
    if ($myjobs->[$n]{'id'} == $idlejobs->[$m]{'id'}) {
      $myjobs->[$n]{'status'} = $idlejobs->[$m]{'status'};
      last;
    }
  }
  for (my $m = 0; $m < scalar(@{$blockedjobs}); $m++) {
    if ($myjobs->[$n]{'id'} == $blockedjobs->[$m]{'id'}) {
      $myjobs->[$n]{'status'} = $blockedjobs->[$m]{'status'};
      last;
    }
  }
  printf("%7d %8s %s\n", 
         $myjobs->[$n]{'id'}, $myjobs->[$n]{'status'}, 
         $myjobs->[$n]{'dir'});
  `echo $myjobs->[$n]{'id'} $myjobs->[$n]{'dir'} $myjobs->[$n]{'status'} >> ~/mymsubjobs`;
}

