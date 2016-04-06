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
   foreach my $i (1..100) {
      print "$i: ";
      $| = 1;
      my $c = getAllTrianglesWithPerimeter($i);
      print $c."\n";
   }
}


sub getAllTrianglesWithPerimeter {
   my $p = shift || 1;
   
   my $count = 0;
   my $OUTFILE = undef;
   open ($OUTFILE, '>>'.$fn) or die "Could not open $fn for append.\n$!\n";
   
   my @cur = (1,1,$p-2);
   
   while ($cur[0] <= $cur[2]) {
      while ($cur[1] <= $cur[2]) {
         if ($cur[0] + $cur[1] >= $cur[2]) {
            print $OUTFILE $cur[0]."\t".$cur[1]."\t".$cur[2]."\n";
            $count += 1;
         }
         $cur[2] -= 1;
         $cur[1] += 1;
      }
      $cur[0] += 1;
      $cur[1] = $cur[0];
      $cur[2] = $p - $cur[1] - $cur[0];
   }
   
   close ($OUTFILE);
   
   return $count;
}
   



