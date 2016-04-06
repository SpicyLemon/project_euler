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
   
   my $m = $start;
   while ($total == 0) {
      my $pm = getP($m);
      foreach my $k ( reverse (1..$m)) {
         my $pk = getP($k);
         last if ($pk + $pk < $pm);
         if (my $j = getN($pm - $pk)) {
            my $pj = getP($j);
            print "m: $m\tpm: $pm\tk: $k\tpk: $pk\tj: $j\tpj: $pj\t";
            if (my $h = getN($pk - $pj)) {
               my $ph = getP($h);
               print "h: $h\tph: $ph\t";
               $total = $ph;
            }
            print "\n";
         }
      }
      $m += 1;
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


sub getN {
   my $p = shift || 0;
   my $n = int(1/6 + sqrt(1/4 + 6*$p)/3);
   my $pn = getP($n);
   return ($p == $pn) ? $n : 0;
}

