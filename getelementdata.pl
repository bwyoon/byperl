#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################


my @argv = @ARGV;
my $argc = @argv;
my $mainurl = 'https://www.webelements.com';
my $url;

my $elem = $argv[0];

if ($argc != 1) {
    warn("USAGE: getelementdata Xx\n");
    exit(1);
}

my @lines = `curl -D /dev/null -o - -k -s $mainurl`;
for (@lines) {
    if (/<a class="sym" href="([^"]+)">$elem</) {
        $url = "$mainurl/$1";
        #print "$url\n";
        last;
    }
}

@lines = `curl -D /dev/null -o - -k -s $url`;
for (@lines) {
    if (/<li><a[^>]+>([^<]+)<\/a>([^<]+)/) {
        print "$1 $2\n";
    }

}

