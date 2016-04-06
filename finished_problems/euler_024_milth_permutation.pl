#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;
use List::Permutor;


my $max = 10;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}




mainProgram();
exit(0); 



sub mainProgram {

   my $total = 0;
   
   my $perm = List::Permutor->new(split(//, '0123456789'));
   my $c = 1;
   while ($total == 0) {
      my @set = $perm->next;
      if (! @set) {
         $total = -1;
      }
      if ($c == $max) {
         $total = join('', @set);
         print "permutation $c: ";
      }
      $c += 1;
   }
   
   print "$total\n";


}






