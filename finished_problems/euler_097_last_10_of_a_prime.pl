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

   my $time_start = time;
   my $answer = 0;
   
   $answer = lastTenMul(28433, lastTenExp(2, 7830457)) + 1;
   
   my $time_stop = time;
   my $elapsed_time = $time_stop - $time_start;
   print "Elapsed time (seconds): $elapsed_time\n";
   print "Answer: $answer\n";


}



sub lastTenExp {
   my $x = shift || 0;
   my $y = shift || 0;
   
   my $retval = '1';
   foreach (1..$y) {
      $retval = lastTenMul($retval, $x);
   }
   
   return $retval;
}



sub lastTenAdd {
   my $x = shift || 0;
   my $y = shift || 0;   
   $x = substr(('0' x 10).$x, -10);
   $y = substr(('0' x 10).$y, -10);
   
   my $retval = '';
   my $carry = 0;

   foreach my $i (reverse (0..9)) {
      my $d = substr($x, $i, 1) + substr($y, $i, 1) + $carry;
      if ($d >= 10) {
         $carry = 1;
         $d = substr($d, -1);
      }
      else {
         $carry = 0;
      }
      $retval = $d.$retval;
   }
   
   return $retval;
}


sub lastTenMul {
   my $x = shift || 0;
   my $y = shift || 0;
   $x = substr(('0' x 10).$x, -10);
   $y = substr(('0' x 10).$y, -10);
   
   my $retval = '';
   my $carry = 0;

   foreach my $d (reverse (0..9)) {
      my @is = ($d..9);
      my $r = 0;
      foreach my $i (0..$#is) {
         $r += substr($x, $is[$i], 1) * substr($y, $is[$#is-$i], 1);
      }
      $r += $carry;
      $carry = int($r/10);
      $r = $r % 10;
      $retval = $r.$retval;
      
   }
   
   #                g            h        i   j
   #x               q            r        s   t
   #-------------------------------------------
   #...[gt+hs+ri+qj+c][ht+is+jr+c][it+sj+c][jt]
   
   return $retval;
}




