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

   my @f = (Math::BigInt->new(1), Math::BigInt->new(1));
   
   my $i = 2;

   while ($f[1]->length() < 1000) {
      my $f1 = $f[1];
      my $f2 = $f[1] + $f[0];
      @f = ($f1, $f2);
      $i += 1; 
   }
   print "$i\n";

}






