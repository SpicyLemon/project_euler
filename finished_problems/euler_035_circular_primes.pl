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

   my $total = 13;   #2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, 97
   
   
   myMath::initializePrimeList(1000000);
   
   my %primes = ();
   foreach my $p (@myMath::primes) {
      $primes{$p} = 1;
   }
   
   print "primes loaded, commencing check!\n";
   
   my %good = ();
   my %bad = ();
   foreach my $p (keys %primes) {
      if (! exists $bad{$p} && ! exists $good{$p} && length($p) > 2) {
         my @rots = @{getAllRots($p)};
         my $is_circular = 1;
         foreach my $r (@rots) {
            if (! exists $primes{$r}) {
               $is_circular = 0;
               last;
            }
         }
         if ($is_circular) {
            foreach my $r (@rots) {
               $good{$r} = 1;
            }
            print "$p\n";
         }
         else {
            foreach my $r (@rots) {
               $bad{$r} = 1;
            }
         }
      }
   }
   
   $total += scalar keys %good;
   
   print "$total\n";
}


sub getAllRots {
   my $v = shift;
   
   my @retval = ($v);
   
   foreach my $i (1..(length($v)-1)) {
      push (@retval, substr($v.$v, $i, length($v)));
   }
   
   return \@retval;
}


