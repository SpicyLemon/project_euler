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
   
   my @fractions = ();
   
   foreach my $n (1..9) {
      foreach my $d (1..9) {
         foreach my $c (1..9) {
            next if ($d == $c && $n == $c);
            my $n1 = $n.$c;
            my $d1 = $c.$d;
            my $n2 = $c.$n;
            my $d2 = $d.$c;
            my $v = $n/$d;
            if ($n1 < $d1 && abs($v - $n1/$d1) < .0001) {
               push (@fractions, { n1 => $n1, d1 => $d1, n => $n, d => $d});
            }
            if ($n2 < $d2 && abs($v - $n2/$d2) < .0001) {
               push (@fractions, { n2 => $n2, d2 => $d2, n => $n, d => $d});
            }
         }
      }
   }
   
   print Dumper(\@fractions)."\n";
   
   my $n = 1;
   my $d = 1;
   
   foreach my $f (@fractions) {
      $n *= $f->{n};
      $d *= $f->{d};
   }
   print "$n / $d = ".($n/$d)."\n";
            
   
   print "$total\n";


}






