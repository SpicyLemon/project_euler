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
   
   my %products = ();
   
   my $pand = '123456789';
   
   foreach my $i (1..5000) {
      foreach my $j (1..5000) {
         my $p = $i * $j;
         my $c = $i.$j.$p;
         if (length($c) == 9 && join('', sort split(//, $c)) eq $pand) {
            push (@{$products{$p}}, { i => $i, j => $j });
         }
         elsif (length($c) > 9) {
            last;
         }
      }
   }
   
   print Dumper(\%products)."\n";
   
   foreach my $k (keys %products) {
      $total += $k;
   }
   
   
   print "$total\n";


}






