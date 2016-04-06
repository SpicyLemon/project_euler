#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;
use Time::HiRes qw(time usleep);  #this forces the time() function to return nanosecond information

my $v = 1;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $v = $1;
}

mainProgram();
exit(0); 



sub mainProgram {
   print "Triangle sides with length $v\n";
   my $time_start = time;
   my $ts = getAllTrianglesWithPerimeter($v);
   my $time_end = time;
   if ($#$ts <= 20) {
      foreach my $t (@$ts) {
         print '('.join(', ', @$t).")\n";
      }
   }
   else {
      print "There are $#$ts triangles with perimeter $v\n";
   }
   my $calc_time = $time_end - $time_start;
   my $s = substr('0'.($calc_time % 60), -2);
   my $m = substr('0'.(int($calc_time / 60)), -2);
   print "calculation time: $m:$s\n";
}


sub getAllTrianglesWithPerimeter {
   my $p = shift || 1;
   my @retval = ();
   my @cur = (1,1,$p-2);
   
   while ($cur[0] <= $cur[2]) {
      while ($cur[1] <= $cur[2]) {
         if ($cur[0] + $cur[1] >= $cur[2]) {
            push (@retval, [$cur[0], $cur[1], $cur[2]]);
         }
         $cur[2] -= 1;
         $cur[1] += 1;
      }
      $cur[0] += 1;
      $cur[1] = $cur[0];
      $cur[2] = $p - $cur[1] - $cur[0];
   }
   
   return \@retval;
}
   



