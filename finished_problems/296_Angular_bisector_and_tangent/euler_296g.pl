#!/usr/bin/perl
use strict;
use warnings;
use Math::BigInt;
use myMath;

#max number to factor will be 50000 * 25000 = 1250000000
#sqrt(1250000000) is a little over 35355
#initializing the primes below 36000 should be plenty.
myMath::initializePrimeList(36000);

mainProgram();
exit(0); 



sub mainProgram {

   my $answer = Math::BigInt->new(0);
   
   foreach my $aa (1..33333) {
      my $aa_factors = myMath::factor($aa);
      my $subtotal = 0;
      my $maxb = int((100000-$aa)/2);
      foreach my $bb ($aa..$maxb) {
         my $ab = $aa + $bb;
         my $ab_factors = myMath::factor($ab);
         foreach my $af (@$aa_factors) {
            my $found = undef;
            foreach my $i (0..$#$ab_factors) {
               if ($af == $ab_factors->[$i]) {
                  $found = $i;
                  last;
               }
            }
            if (defined $found) {
               splice(@$ab_factors, $found, 1, ());
            }
         }
         my $minc = 1;
         foreach my $cf (@$ab_factors) {
            $minc *= $cf;
         }
         my $maxc = 100000 - $ab;
         if ($ab < $maxc) {
            $maxc = $ab;
         }
         
         my $count = int( $maxc / $minc ) - int( $bb / $minc );
         $subtotal += $count;
      }
      $total->badd($subtotal);
      print "a: $aa -> $subtotal -> total so far: $answer\n";
   }
      
   
   
   
   
   
   print "answer: $answer\n";

}



