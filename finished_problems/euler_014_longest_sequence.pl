#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;





mainProgram();
exit(0); 



sub mainProgram {

   my $maxi = 0;
   my $max = 0;

   foreach my $i (1..1000000) {
      my $c = $i;
      my $n = 1;
      while ($c != 1) {
         $c = collatz($c);
         $n += 1;
      }
      print "$i : $n\n";
      if ($n > $max) {
         $max = $n;
         $maxi = $i;
      }
   }

   print "max: $max\nstarts with $maxi\n";

}




sub collatz {
   my $f = shift || 1;

   my $retval = ($f == 1)     ? 1      
              : ($f % 2 == 0) ? $f / 2 
              :                 $f * 3 + 1
             ;

   return $retval;
}
