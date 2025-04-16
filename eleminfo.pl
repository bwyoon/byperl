#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

use BY::Element;

if (scalar(@ARGV) < 1) {
    print stderr "USAGE: elemmas.pl Xx\n";
    exit(1);
}

my $anum = BY::Element::GetAtomicNumber($ARGV[0]);
print "atomic number : $anum\n";
my $name = BY::Element::GetName($anum);
print "atomic name   : $name \n";
my $mass = BY::Element::GetAtomicMass($anum);
print "atomic mass   : $mass \n";
my $str = BY::Element::GetCrystalStructure($anum);
print "crystal structure : $str\n";
my @cp = BY::Element::GetCellParameters($anum);
print "cell parameters : @cp\n";
my $cpk = BY::Element::GetCPKColor($anum);
print "CPK color : $cpk\n";
