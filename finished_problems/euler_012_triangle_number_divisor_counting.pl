#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;





mainProgram();
exit(0); 



sub mainProgram {

   my $f = 0;

   foreach my $i (1..1000000) {
      $f += $i;
      my @divisors = @{myMath::getDivisors($f)};
      print "$i : $f (".(scalar @divisors).")\n";
      if ((scalar @divisors) >= 500) {
         last;
      }
   }

}






