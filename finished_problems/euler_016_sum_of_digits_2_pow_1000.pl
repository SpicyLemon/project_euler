#!/usr/bin/perl 
use strict;
use warnings;
use Math::BigInt;



mainProgram();
exit(0);


sub mainProgram {

   my $x = Math::BigInt->new(2);
   
   $x->bpow(1000);
   
   my $str = $x->bstr();
   
   my $tot = 0;
   foreach my $d (split(//, $str)) {
      $tot += $d;
   }
   
   print $tot."\n";

}


