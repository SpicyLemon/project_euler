#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;


my @p = (0);

my $start = 1;
if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $start = $1;
}

mainProgram();
exit(0); 



sub mainProgram {

   my $total = 0;
   
   my $h = $start;
   while ($total == 0) {
      my $ph = getP($h);
      my $j = $h + 1;
      my $k = $j + 1;
      my $pj = getP($j);
      my $pk = getP($k);
      my $keep_going = 1;
      my $pjk_sum = 0;
      while ($keep_going) {
         if ($pk - $pj == $ph) {
            $pjk_sum = $pk + $pj;
         }
         elsif ($pk - $pj > $ph) {
            #the difference is too great,
            #If j and k are consecutive, then
            #we can stop checking this h
            if ($k - $j == 1) {
               $keep_going = 0;
            }
            else {
               #otherwise, start at the next j over
               $j += 1;
               $k = $j + 1;
               $pj = getP($j);
               $pk = getP($k);
            }
         }
         else {
            #pk - pj < ph
            #go to the next k
            $k += 1;
            $pk = getP($k);
         }
         
         if ($pjk_sum) {
            print "h: $h = $ph = $pk - $pj = p$k - p$j\t";
            #ooooo! we might have something here! Check to see if the sum of the two
            #is also a pentagonal number.
            my $m = int(1 / 6 + sqrt(1/4 + 6 * $pjk_sum) / 3);
            my $pm = getP($m);
            #if it's an integer, we're golden!
            if ($pm == $pjk_sum) {
               print "Wooo! $m = $m\n".
                     "h: $h = $ph\n".
                     "j: $j = $pj\n".
                     "k: $k = $pk\n".
                     "m: $m = $pm\n";
               $total = $pk - $pj;
            }
            else {
               print "nope: m = $m\tpm = $pm != $pjk_sum\n";
               $pjk_sum = 0;
               $k += 1;
               $pk = getP($k);
            }
         }
      }
            
      $h += 1;
      $ph = getP($h);
   }     
         
   print "$total\n";
}



sub getP {
   my $n = shift || 0;
   my $retval = $p[$n];
   if (! defined $retval) {
      $retval = $n * (3 * $n - 1) / 2;
      $p[$n] = $retval;
   }
   return $retval;
}


