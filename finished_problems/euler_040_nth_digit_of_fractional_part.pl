#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;





mainProgram();
exit(0); 



sub mainProgram {

   my $total = 1;
   
   foreach my $e (0..6) {
      my $i = 10 ** $e;
      $total *= nthdigit($i);
   }
   
   print "$total\n";

}


sub nthdigit {
   my $n = shift || 1;
   my $cfp = 1;   #current fractional part
   my $s = 1;     #start (digit count)
   while ($s + length($cfp) <= $n) {
      $s += length($cfp);
      $cfp += 1;
   }
   my $retval = substr($cfp, $n - $s, 1);
   return $retval;
}




