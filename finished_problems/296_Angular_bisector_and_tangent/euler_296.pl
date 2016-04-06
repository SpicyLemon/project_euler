#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;

my $max = 100000;
my $astart = 215;          #last a + 1
my $tstart = '578557646';  #last number in ()


mainProgram();
exit(0); 



sub mainProgram {

   my $total = Math::BigInt->new($tstart);
   
   my $maxa = int($max/2);
   
   foreach my $aa ($astart..$maxa) {
      my $subt = 0;
      foreach my $bb ($aa..$max) {
         last if ($aa + $bb > $max);
         foreach my $cc ($bb..$max) {
            if ($aa + $bb < $cc) {
               #not a triangle
               last;
            }
            elsif ($aa + $bb + $cc > $max) {
               #too big
               last;
            }
            else {
               my $eb = $aa * $cc / $bb;
               if ($eb % 2 == 0) {
                  $subt += 1;
               }
            }
         }
      }
      if ($subt) {
         $total->badd($subt);
      }
      print "a: $aa [$subt] -> ($total)\n";
   }
   
   
   print "$total\n";

}






