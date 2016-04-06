#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;


my $max = 10;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}




mainProgram();
exit(0); 



sub mainProgram {

   my $total = 0;
   my $high = 0;
   
   myMath::initializePrimeList($max);
   
   $high = 1;
   foreach my $p (@myMath::primes) {
      my $nexthigh = $high * $p;
      if ($nexthigh > $max) {
         last;
      }
      else {
         $high = $nexthigh;
      }
   }
   print $high."\n";
   exit(0);
   
   #this would take forever. I found a better way above.
   
   my %prime = ();
   foreach my $p (@myMath::primes) {
      $prime{$p} = 1;
   }
   
   foreach my $n (1..$max) {
      next if exists $prime{$n};    #no need to check primes.
      my $p = phi($n);
      my $v = $n / $p;
      if ($v > $high) {
         $total = $n;
         $high = $v;
      }
      if ($n % 1000 == 0) {
         print "($total)\t$n\t$p\t$v\n";
      }
   }
   
   print "$total\n";


}



sub phi {
   my $n = shift;
   my $retval = 1;
   foreach my $i (2..($n-1)) {
      $retval += relativelyPrime($n, $i);
   }
   return $retval;
}


sub relativelyPrime {
   my $big = shift;
   my $small = shift;
   if ($big < $small) {
      ($big, $small) = ($small, $big);
   }
   my $rem = $big % $small;
   #print "---\n";
   #print "$big = $small * x + $rem\n";
   while ($rem > 1) {
      $big = $small;
      $small = $rem;
      $rem = $big % $small;
      #print "$big = $small * x + $rem\n";
   }
   return ($rem == 1) ? 1 : 0;
}





