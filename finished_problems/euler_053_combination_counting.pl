#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;


my @pt = ([1], [1, 1], [1, 2, 1]);

my $max = 5;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}

mainProgram();
exit(0); 



sub mainProgram {

   my $total = 0;
   
   $max += 1;
   $total = createPascalsTriangle($max);
   
   #print Dumper(\@pt)."\n";
   
   print "$total\n";
}


sub createPascalsTriangle {
   my $max_row = shift || '4';
   
   my $retval = 0;
   
   while (scalar @pt < $max_row) {
      my @new_row = (1);
      foreach my $i (1..$#{$pt[-1]}) {
         my $new_val = $pt[-1]->[$i-1] + $pt[-1]->[$i];
         #limit the new value to 1,000,000 since that's all we care about
         #take this out if you want the real value
         if ($new_val > 1000000) {
            $new_val = 1000000;
            $retval += 1;
         }
         push (@new_row, $new_val);
      }
      push (@new_row, 1);
      push (@pt, \@new_row);
   }
   
   return $retval;
}
         
         




