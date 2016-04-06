#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;


my @factors = ();

my $c = 4;  #looking for $c consecutive integers with $c distinct prime factors
my $start = 5;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $start = $1;
}

mainProgram();
exit(0); 



sub mainProgram {

   my $total = 0;
   
   myMath::initializePrimeList(100000);
   
   #grab the last, and the current one
   foreach my $i (0..($c-1)) {
      push (@factors, myMath::factor_hash($start-$i));
   }
   
   my $i = $start;
   while ($total == 0) {
      #check what we've got.
      my $all = 1;
      foreach my $fset (@factors) {
         if (scalar keys %$fset != $c) {
            $all = 0;
            last;
         }
      }
      
      if ($all) {
         $total = $i - $c + 1;
      }
      else {
         #oh well, on to the next set
         $i += 1;
         pop(@factors); #get rid of the oldest one
         unshift(@factors, myMath::factor_hash($i));
      }
   }
   
   print Dumper(\@factors)."\n";
   
   print "$total\n";


}







