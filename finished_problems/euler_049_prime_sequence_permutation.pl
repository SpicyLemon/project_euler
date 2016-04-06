#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;


my @primes = myMath::getPrimesBelow(10000);



mainProgram();
exit(0); 



sub mainProgram {

   #sort all 4 digit primes into a hash where the key is the digits in the
   #prime number, in order.
   my %pd = ();
   foreach my $p (@primes) {
      next if ($p < 1000);
      my $k = join('', sort split(//, $p));
      if (defined $pd{$k}) {
         push (@{$pd{$k}}, $p);
      }
      else {
         $pd{$k} = [ $p ];
      }
   }
   
   my @to_test = ();
   foreach my $d (keys %pd) {
      if (scalar @{$pd{$d}} > 3) {
         push (@to_test, $pd{$d});
      }
   }
   
   my @answers = ();
   foreach my $set (@to_test) {
      foreach my $i (2..$#$set) {
         my $dif1 = $set->[$i] - $set->[$i-1];
         my $dif2 = $set->[$i-1] - $set->[$i-2];
         if ($dif1 == $dif2) {
            push (@answers, [ $set->[$i-2], $set->[$i-1], $set->[$i] ]);
         }
         if ($set->[$i] == 1487 || $set->[$i-1] == 1487 || $set->[$i-2] == 1487) {
            print "dif1: $dif1\tdif2: $dif2\n";
         }
      }
   }
   
   print Dumper(\@answers)."\n";

}






