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

   my $total = 0;
   
   my $pn = 166;
   while ($total == 0) {
      my $p = $pn * (3 * $pn - 1) / 2;
      print "$p: pn = $pn\t";
      #check if it's a triangle number
      my $tn = int(sqrt($p*2));
      if ($tn * ($tn + 1) eq 2*$p) {
         print "tn = $tn\t";
         #Triangle passed, check for hex!
         my $hn = (1 + sqrt(1 + 8 * $p))/4;
         if ($hn == int($hn)) {
            $total = $p;
            print "hn = $hn\t";
         }
      }
      $pn += 1;
      print "\n";
   }
   
   print "$total\n";


}






