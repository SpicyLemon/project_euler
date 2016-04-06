#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Data::Dumper;





mainProgram();
exit(0); 



sub mainProgram {
   my @d = (0);

   #calculate sum of proper divisors for all numbers in question
   foreach my $i (1..10000) {
      my @s = @{myMath::getDivisors($i)};
      my $t = 0;
      foreach my $f (@s) {
         $t += $f if ($f != $i);
      }
      #print "$i: $t\n";
      push (@d, $t);
   }

   my %an = ();

   foreach my $i (1..$#d) {
      my $v1 = $d[$i] || 0;
      my $v2 = $d[$v1] || 0;
      if ($v1 && $v2 && $v1 != $i && $i == $v2) {
         $an{$v1} = 1;
         $an{$v2} = 1;
      }
   }

   print Dumper(\%an)."\n";
   print $d[220].' '.$d[284]."\n";
   print $d[6].' '.$d[496]."\n";

   my $total = 0;
   foreach my $k (keys %an) {
      $total += $k;
   }

   print "$total\n";
      




}






