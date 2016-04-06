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
   
   foreach my $v (1..999999) {
      if ($v % 10000 == 0) {
         print "$v: $total";
      }
      if (isPalindrome($v)) {
         my $b = sprintf("%20b", $v);
         $b =~ s/^\s+//;
         if (isPalindrome($b)) {
            $total += $v;
         }
      }
   }
   
   print "$total\n";


}


sub isPalindrome {
   my $v = shift;
   return ($v eq join('', reverse split(//, $v))) ? 1 : 0;
}



