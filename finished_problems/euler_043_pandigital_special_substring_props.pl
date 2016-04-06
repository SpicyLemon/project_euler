#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;
use List::Permutor;


my @possibilities = split(//, '0123456789');
my @divs = (undef, 2, 3, 5, 7, 11, 13, 17);


mainProgram();
exit(0); 



sub mainProgram {

   my $total = 0;
   
   my $perm = List::Permutor->new(@possibilities);
   while (my @p = $perm->next()) {
      my $isgood = 1;
      foreach my $i (1..7) {
         my $s = $p[$i].$p[$i+1].$p[$i+2];
         if ($s % $divs[$i] != 0) {
            $isgood = 0;
            last;
         }
      }
      if ($isgood) {
         my $d = join('', @p);
         $total += $d;
         print "$total <- $d\n";
      }
   }
   
   print "$total\n";


}






