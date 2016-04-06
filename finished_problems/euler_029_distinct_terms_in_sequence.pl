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

   my %values = ();

   foreach my $aa (2..100) {
      foreach my $bb (2..100) {
         my $v = Math::BigInt->new($aa)->bpow($bb);
         $values{$v->bstr} = 1;
      }
   }
   
   my @numbers = keys %values;
   my $count = scalar @numbers;
   
   print $count."\n";


}





