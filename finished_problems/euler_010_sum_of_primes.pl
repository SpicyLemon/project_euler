#!/usr/bin/perl
use strict;
use warnings;

my $i = 3;

mainProg();

sub mainProg {
   my $tot = 2;
   my $mil = 0;
   while ($i < 2000000) {
      $tot += $i if isPrime($i);
      $i += 2;
      while ($tot >= 1000000) {
         $mil += 1;
         $tot -= 1000000;
      }
   }
   print $mil.' '.$tot."\n";
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



