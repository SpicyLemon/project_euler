#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;


#load the primes into a hash!
my %primes = ();
open (INFILE, 'primes.txt') or die "Could not open primes.txt for reading.\n$!\n";
while(<INFILE>) {
   chomp;
   $primes{$_} = 1;
}
close(INFILE);



mainProgram();
exit(0); 



sub mainProgram {

   my $max = 0;
   my $maxa = 0;
   my $maxb = 0;
   foreach my $aa (-1000..1000) {
      print ".";
      if (abs($aa) % 25 == 0) {
         print "\n";
      } else {
         $| = 1;
      }
      foreach my $bb (-1000..1000) {
         my $n = 0;
         my $v = $n * $n + $aa * $n + $bb;
         while (exists $primes{$v}) {
            $n += 1;
            $v = $n * $n + $aa * $n + $bb;
         }
         if ($n > $max) {
            $max = $n;
            $maxa = $aa;
            $maxb = $bb;
         }
      }
   }
   
   my $prod = $maxa * $maxb;
   
   print "max consecutive n: $max\n"
        ."a: $maxa\n"
        ."b: $maxb\n"
        ."a * b = $prod\n";
}





