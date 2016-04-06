#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;

my $a1 = 2;
my $a2 = 3;
if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $a1 = $1;
}
if ($ARGV[1] && $ARGV[1] =~ /^(\d+)$/) {
   $a2 = $1;
}



mainProgram();
exit(0); 



sub mainProgram {

   my $total = 0;
   foreach my $i (1..1000) {
      my $v = lastTenExp($i, $i);
      $total += $v;
      $total = substr($total, -10);
   }
   
   print "$total\n";
   #print " my way: $a1 ^ $a2 = ".lastTenExp($a1, $a2)."\n";
   #print "highway: $a1 ^ $a2 = ".substr(('0'x10).($a1 ** $a2), -10)."\n";
   


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
      