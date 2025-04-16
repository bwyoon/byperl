#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

print "What is your name ?\n";
$name= <STDIN>;
print "Hello $name\n";

open(DATA, "<file.txt") or die "Can't open file";
@lines = <DATA>;
print @lines;
close(DATA);
print "\n";

open(DATA, "<file.txt") or die "Can't open file.";
while ($line=<DATA>) {
  print $line;
}
print "\n";

open(DATA1, "<file.txt");
open(DATA2, ">file2.txt");

while (<DATA1>) {
    print DATA2 $_;
}
close(DATA1);
close(DATA2);

