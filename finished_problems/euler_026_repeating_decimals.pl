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

   if (0) {
      foreach my $i (2..30) {
         print "1/$i = ";
         $| = 1;
         my $inv = invert($i, 20);
         print "$inv : ";
         $| = 1;
         my $cycle = findCycle($i);
         print "$cycle\n";
      }
   }
   
   my @primes = myMath::getPrimesBelow(1000);
   my $maxl = 0;
   my $maxi = 0;
   my $maxcycle = '';
   foreach my $i (@primes) {
      print substr('   '.$i, -3).": ";
      $| = 1;
      my $cycle = findCycle($i);
      if (length($cycle) > $maxl) {
         $maxl = length($cycle);
         $maxi = $i;
         $maxcycle = $cycle;
      }
      print ''.(length($cycle))."\n";
   }
   
   print "     i: $maxi\n";
   print " cycle: $maxcycle\n";
   print "length: $maxl\n";


}



sub invert {
   my $val = shift || 1;
   my $pre = shift || 20;
   my $just_decimal = shift || 0;
   
   my $retval = '';
   
   my $cur = 10;
   
   while (length($retval) < $pre) {
      my $n = int($cur/$val);
      $retval .= $n;
      $cur = ($cur - $n * $val) * 10;
   }
   
   if (! $just_decimal) {
      $retval = '0.'.$retval;
   }
   
   return $retval;
}
   
   
sub findCycle {
   my $val = shift || 0;
   
   my $pre = 20;
   
   my $retval = undef;
   
   while (! defined $retval) {
      my $dec = invert($val, $pre, 1);
      #print "dec = $dec\n";
      foreach my $l (1..int($pre/3)) {
         my $dec1 = substr($dec, $pre-($l*1), $l);
         my $dec2 = substr($dec, $pre-($l*2), $l);
         my $dec3 = substr($dec, $pre-($l*3), $l);
         #print "$l =>\tdec1: '$dec1'\tdec2: '$dec2'\tdec3: '$dec3'\n";
         #my $dkdk = <STDIN>;
         if ($dec1 eq $dec2 && $dec2 eq $dec3) {
            $retval = $dec1;
            #print "retval = $retval\n";
            last;
         }
      }
      $pre *= 3;
   }
   
   return $retval;
}
   
   
   
   
   
   
   
   
   
   
   


