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
   
   foreach my $x1 (0..$max) {
      foreach my $y1 (0..$max) {
         foreach my $x2 (0..$max) {
            foreach my $y2 (0..$max) {
               if (($x1 == $x2 && $y1 == $y2) ||
                   ($x1 == 0 && $y1 == 0)     ||
                   ($x2 == 0 && $y2 == 0)      ) {
                  next;
               }
               my $x = $x2-$x1;
               my $y = $y2-$y1;
               $x *= $x;
               $y *= $y;
               my $aa2 = $x + $y;
               my $bb2 = $x1*$x1 + $y1*$y1;
               my $cc2 = $x2*$x2 + $y2*$y2;
               if ($aa2 + $bb2 == $cc2 ||
                   $aa2 + $cc2 == $bb2 ||
                   $bb2 + $cc2 == $aa2) {
                  #print "(0, 0)-($x1, $y1)-($x2, $y2)\n";
                  $total += .5;
               }
            }
         }
      }
   }
   
   print "$total\n";


}






