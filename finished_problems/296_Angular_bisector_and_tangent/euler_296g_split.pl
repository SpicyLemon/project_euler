#!/usr/bin/perl
use strict;
use warnings;
use Math::BigInt;
use myMath;

#max number to factor will be 50000 * 25000 = 1250000000
#sqrt(1250000000) is a little over 35355
#initializing the primes below 36000 should be plenty.
myMath::initializePrimeList(36000);


my $astart = 1;
my $astop = 33333;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $astart = $1;
   if ($ARGV[1] && $ARGV[1] =~ /^(\d+)$/) {
      $astop = $1;
   }
}

if ($astart > $astop) {
   ($astart, $astop) = ($astop, $astart); #swap them
}
if ($astart < 1) {
   $astart = 1;
}
if ($astop > 33333) {
   $astop = 33333;
}


mainProgram();
exit(0); 

#total = 1762115111
my $results = q^
#a:       1 - 400:  20573399
#a:    401 - 3500: 201921279
#a:   3501 - 6000: 196731122
#a:   6001 - 9500: 293628633
#a:  9501 - 10750: 104952762
#a: 10751 - 11375:  51646611
#a: 11376 - 12000:  51224277
#a: 12001 - 16500: 340649539
#a: 16501 - 17250:  50747625
#a: 17251 - 18000:  48208102
#a: 18001 - 24000: 285014237
#a: 24001 - 30000: 106910187
#a: 30001 - 33333:   9907338
^;

my $total = 0;
my $last_stop = 0;
foreach my $line (split(/\n/, $results)) {
   if ($line =~ /^\#a\:\s+(\d+)\s+\-\s+(\d+)\:\s+(\d+)\s*$/) {
      my $range_start = $1;
      my $range_end = $2;
      my $v = $3;
      $total += $v;
      if ($range_start != $last_stop + 1) {
         print "Range break: $line\n";
      }
      $last_stop = $range_end;
   }
   else {
      print "Parse failed: $line\n" unless ($line =~ /^\s*$/);
   }
}
print "$total\n";
exit(0);


sub mainProgram {

   my $answer = Math::BigInt->new(0);
   
   foreach my $aa ($astart..$astop) {
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
         if ($ab - 1 < $maxc) {
            $maxc = $ab - 1;
         }
         
         my $count = int( $maxc / $minc ) - int( ($bb - 1) / $minc);
         $subtotal += $count;
      }
      $answer->badd($subtotal);
      print "a: $aa -> $subtotal -> total so far: $answer\n";
   }
   
   
   print "a start: $astart\n";
   print " a stop: $astop\n";
   print "--------------------\n";
   print "  total: $answer\n";

}



