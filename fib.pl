#/usr/bin/perl
use strict;
use warnings;

my @f = (1, 1);
my $i = 3;

while (1) {
   my $f1 = $f[1];
   my $f2 = $f[1] + $f[0];
   print $i.': '.$f2;
   my $x = <STDIN>;
   @f = ($f1, $f2);
   $i += 1;
}
