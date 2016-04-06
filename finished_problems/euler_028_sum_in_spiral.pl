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

   my $max = 1001;

   my $total = 1;

   my $side = 1;

   my $i = 1;

   while ($side < $max) {
      $side += 2;
      foreach (1..4) {
         $i += ($side - 1);
         $total += $i;
      }
   }

   print $total."\n";

}






