#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;



mainProgram();

exit(0); 



sub mainProgram {
   my $v = Math::BigInt->new(100)->bfac();

   my $str = $v->bstr();

   my $val = 0;
   foreach my $d (split(//, $str)) {
      $val += $d;
   }

   print $str."\n";
   print "length: ".length($str)."\n";
   print "digit sum: ".$val."\n";

}






