#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;

my $fn = 'euler_296_triangle_sides.txt';


mainProgram();
exit(0); 



sub mainProgram {
   my $total = Math::BigInt->new(0);
   foreach my $i (1..100) {
      print "$i: ";
      $| = 1;
      my $c = doAllTrianglesWithPerimeter($i);
      $total->badd($c);
      print $c."\n";
   }
}


sub doAllTrianglesWithPerimeter {
   my $p = shift || 1;
   
   my $count = 0;

   my @cur = (1,1,$p-2);
   
   while ($cur[0] <= $cur[2]) {
      while ($cur[1] <= $cur[2]) {
         if ($cur[0] + $cur[1] >= $cur[2] && ($cur[0] * $cur[2] / $cur[1]) % 2 == 0) {
            $count += 1;
         }
         $cur[2] -= 1;
         $cur[1] += 1;
      }
      $cur[0] += 1;
      $cur[1] = $cur[0];
      $cur[2] = $p - $cur[1] - $cur[0];
   }

   return $count;
}
   



