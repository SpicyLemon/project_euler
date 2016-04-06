#!/usr/bin/perl
use strict;
use warnings;

my $i = 3;
my @p = (2);

mainProg();

sub mainProg {
   while ($#p < 10000) {
      push (@p, $i) if isPrime($i);
      $i += 2;
   }
   print $p[10000]."\n";
}

# usage: if (isPrime($v)) {...}
sub isPrime {
   my $f = shift || 4;
   my $retval = 1;
   foreach my $j (2..int(sqrt($f))) {
      if ($f % $j == 0) {
         $retval = 0;
         last;
      }
   }
   return $retval;
}



