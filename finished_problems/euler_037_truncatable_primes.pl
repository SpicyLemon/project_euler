#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;

my $str = '123456789';
my $strl = substr($str, 1);
my $strr = substr($str, 0, -1);

print "'$str'\n";
while (length($strl) > 0) {
   print "'$strl'\n";
   substr($strl, 0, 1, '');
}

print "'$str'\n";
while (length($strr) > 0) {
   print "'$strr'\n";
   substr($strr, -1, 1, '');
}
#exit(0);

mainProgram();
exit(0); 



sub mainProgram {

   my $total = 0;
   
   myMath::initializePrimeList(1000000);   #10,000 should be enough\
   
   my %primes = ();
   foreach my $p (@myMath::primes) {
      $primes{$p} = 1;
   }
   
   my @success = ();
   
   foreach my $p (keys %primes) {
      next if ((length $p) <= 1);
      
      my $is_good = 1;
      
      my $from_left = substr($p, 1);
      while ($is_good && length($from_left) >= 1) {
         if (! exists $primes{$from_left}) {
            $is_good = 0;
         }
         substr($from_left, 0, 1, '');
      }

      my $from_right = substr($p, 0, -1);
      while ($is_good && length($from_right) >= 1) {
         if (! exists $primes{$from_right}) {
            $is_good = 0;
         }
         substr($from_right, -1, 1, '');
      }
      
      if ($is_good) {
         push (@success, $p);
         $total += $p;
      }
   }
   
   @success = sort {$a <=> $b} @success;
   
   print Dumper(@success)."\n";
   
   print "$total\n";


}






