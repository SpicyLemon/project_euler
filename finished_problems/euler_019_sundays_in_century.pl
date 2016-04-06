#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;

#Jan 1, 1900 was a Monday
#  Therefore, Jan 7, 1900 was a Sunday
#leap years on every year divisible by 4, but not 400
#Jan 1, 1910 was therefore a Wednesday

my @days = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31); 


mainProgram();
exit(0); 



sub mainProgram {

   my $count = 0;

   my $d = 3;

   foreach my $y (1901..2000) {
      foreach my $m (0..11) {
         my $dd = $days[$m];
         $dd += 1 if ($m == 1 && $y % 4 == 0);
         $d += $dd;
         $count += 1 if ($d % 7 == 0);
      }
   }

   print $count."\n";

}






