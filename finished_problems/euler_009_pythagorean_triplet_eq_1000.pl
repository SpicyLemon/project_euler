#!/usr/bin/perl
use strict;
use warnings;






mainProgram();
exit(0); 



sub mainProgram {
   foreach my $aa (1..500) {
      my $d = 0;
      foreach my $bb ($aa..500) {
         my $x = sqrt($aa*$aa + $bb*$bb);
         if ($aa + $bb + $x == 1000) {
            print "a: $aa\nb: $bb\nc: $x\n";
            $d = 1;
            last;
         }
      }
      last if $d;
   }

}






