#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;

my $astart = 0;          #last a
my $tstart = '0';  #last number in ()

$astart += 1;

foreach my $tmax (1..1000) {
   mainProgram($tmax);
}
exit(0); 



sub mainProgram {
   my $max = shift || 10;

   my $total = Math::BigInt->new($tstart);
   
   my $maxa = int($max/3);
   
   foreach my $aa ($astart..$maxa) {
      my $subt = 0;
      my $maxb = $max - $aa*2;
      foreach my $bb ($aa..$maxb) {
         my $maxc1 = $aa + $bb;        #makes sure it's a triangle
         my $maxc2 = $max - $aa - $bb; #makes sure it's less than the max
         my $maxc = ($maxc1 < $maxc2) ? $maxc1 : $maxc2; #pick the smallest
         last if ($maxc < $bb);  #if cmax is smaller than b, we're done with this b
         foreach my $cc ($bb..$maxc) {
            my $eb = $aa * $cc / $bb;     #calculate EB * 2, if it's even, then
            if ($eb % 2 == 0) {           #EB ends up being an integer.
               $subt += 1;
            }
         }
      }
      if ($subt) {
         $total->badd($subt);
      }
      #print "a: $aa [$subt] -> ($total)\n";
   }
   
   my $fn = 'euler_296c_out.txt';
   open (OUTFILE, '>>'.$fn) or die "Could not open $fn for append.\n$!\n";
   print OUTFILE "$max -> $total\n";
   print "$max -> $total\n";
   close(OUTFILE);

}






