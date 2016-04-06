#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;


my @f = ();

foreach my $i (0..9) {
   $f[$i] = 1;
   foreach my $j (1..$i) {
      $f[$i] *= $j;
   }
}


mainProgram();
exit(0); 



sub mainProgram {

   my $total = 0;
   
   my @answers = ();
   
   foreach my $i (10..41000) {
      my $st = 0;
      foreach my $d (split(//, $i)) {
         $st += $f[$d];
      }
      if ($st == $i) {
         $total += $i;
         push (@answers, $i);
      }
      if ($i % 1000 == 0) {
         print "$i: $total\n";
      }
   }
   
   
   print "$total\n";
   
   print Dumper(\@answers)."\n";


}






