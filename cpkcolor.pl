#!/usr/bin/perl
###############################
# original author: Bokwon Yoon
###############################

my $mainurl = 'https://en.wikipedia.org/wiki/CPK_coloring';

@lines = `curl -D /dev/null -o - -k -s $mainurl`;

print "num symbol cpk\n";
my $n;
for ($n = 0; $n < scalar(@lines); $n++) {
    if ($lines[$n] =~ m%^<td align="right">([0-9]+)</td>%) {
        $n++;
        my $num = $1;
        if ($lines[$n] =~ m%^<td>([a-zA-Z]+)</td>%) {
            my $sym = $1;
            $n += 4;
            my $cpk = "nodata";
            $cpk = $1 if ($lines[$n] =~ m%^<td><span style="background-color:#([^;]{6});%);
            print "$num $sym $cpk\n";
        }
    }
}

