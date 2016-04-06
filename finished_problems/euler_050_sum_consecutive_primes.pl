#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;


my $max = 1000000;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}

my $do_all = 0;
if ($ARGV[1] && $ARGV[1] =~ /^(\d+)$/) {
   $do_all = 1;
}

#118831 ->       116533  204     0
mainProgram();
exit(0); 



sub mainProgram {

   print "Looking for the prime below $max that is the longest sum of consecutive primes.\n";

   my @primes = myMath::getPrimesBelow($max);
   
   my $istart = ($do_all) ? 1 : int($#primes*9/10);
   
   if (!$do_all) {
      print "Only looking at the primes above ".$primes[$istart]."\n";
   }
   
   
   my $maxprime = 2;
   my $maxlength = 1;
   my $maxstart = 0;
   #print $primes[0]." ->\t2\t1\t0\n";
   foreach my $i (reverse ($istart..$#primes)) {
      my $p = $primes[$i];
      foreach my $j (0..$i-$maxlength) {
         my $total = 0;
         my $length = 0;
         foreach my $k ($j..$i-1) {
            $total += $primes[$k];
            $length += 1;
            if ($total > $p) {
               last;
            }
            elsif ($p == $total) {
               if ($length > $maxlength) {
                  $maxlength = $length;
                  $maxprime = $p;
                  $maxstart = $j;
                  last;
               }
            }
         }
      }
      if ($i % 100 == 0) {
         print "$p ->\t$maxprime\t$maxlength\t$maxstart\n";
      }
   }
   
   my @sums = splice(@primes, $maxstart, $maxlength);

   print "prime: $maxprime\n";
   print "is the sum of $maxlength consecutive primes\n";
   print join(' + ', @sums)."\n";
   
   my $sum = 0;
   foreach my $p (@sums) {
      $sum += $p;
   }
   if ($sum != $maxprime) {
      print "Crap, the double check failed.\n";
      print "I get that those numbers add up to $sum, not $maxprime.\n";
   }
   
   

}






