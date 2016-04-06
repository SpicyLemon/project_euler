#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;
use Time::HiRes qw(time usleep);  #this forces the time() function to return nanosecond information

#On my work computer
#Triangle sides with length 100000
#There are 208358333 triangles with perimeter 100000
#calculation time: 06:54414.890625
#
#That means, just to find every triangle, it'd take 7 minutes / 2 * 100,000 =
# about 243 days.  I have 6 computers that could all be working on this. That'd
# get it down to about 40 days (if everything went right).

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
   print "There are $ts triangles with perimeter $v\n";
   my $calc_time = $time_end - $time_start;
   my $s = substr('0'.(int($calc_time) % 60), -2);
   my $m = substr('0'.(int($calc_time / 60)), -2);
   my $n = $calc_time;
   $n =~ s/^\d\./\./;
   print "calculation time: $m:$s$n\n";
}


sub getAllTrianglesWithPerimeter {
   my $p = shift || 1;
   my $count = 0;
   my @cur = (1,1,$p-2);
   
   while ($cur[0] <= $cur[2]) {
      while ($cur[1] <= $cur[2]) {
         if ($cur[0] + $cur[1] >= $cur[2]) {
            $count += 1;
         }
         $cur[2] -= 1;
         $cur[1] += 1;
      }
      $cur[0] += 1;
      $cur[1] = $cur[0];
      $cur[2] = $p - $cur[1] - $cur[0];
   }
   
   return $count;
}
   



