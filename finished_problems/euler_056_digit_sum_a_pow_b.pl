#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;


my $max = 10;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}




mainProgram();
exit(0); 



sub mainProgram {

   my $total = 0;
   
   foreach my $x (reverse (1..$max)) {
      foreach my $y (reverse (1..$max)) {
         my $v = Math::BigInt->new($x)->bpow($y);
         my $st = 0;
         foreach my $c (split(//, $v)) {
            $st += $c;
         }
         if ($st > $total) {
            $total = $st;
            print "New winner: ($st) $v = $x ^ $y\n";
         }
      }
   }
   
   print "$total\n";


}






