#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;

my @pow5 = ();
foreach my $i (0..9) {
   my $p5 = $i * $i * $i * $i * $i;
   push (@pow5, $p5);
}
#note 9^5 = 59049
#so, let's only look at 6 digits max here


mainProgram();
exit(0); 



sub mainProgram {

   my @hits = ();
   my $total = 0;

   foreach my $i (10..1000000) {
      my $s = 0;
      foreach my $d (split(//, $i)) {
         $s += $pow5[$d];
      }
      if ($s == $i) {
         push (@hits, $i);
         $total += $i;
      }
   }
   
   print join(', ', @hits)."\n";
   print "$total\n";

}





