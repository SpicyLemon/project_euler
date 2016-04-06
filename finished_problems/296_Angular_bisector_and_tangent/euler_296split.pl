#!/usr/bin/perl
use strict;
use warnings;
use Math::BigInt;
use Time::HiRes qw(time);  #this forces the time() function to return nanosecond information

my $min = 1;
my $max = 1;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $min = $1;
}
if ($ARGV[1] && $ARGV[1] =~ /^(\d+)$/) {
   $max = $1;
}
else {
   $max = $min;
   $min = 1;
}

my $fn = "euler_296_split_counts_${min}_${max}.txt";

mainProgram();
exit(0); 



sub mainProgram {
   my $t_start = time;
   my $total = Math::BigInt->new(0);
   open (OUTFILE, '>'.$fn) or die "could not open $fn for writing.\n$!\n";
   print OUTFILE '';
   close(OUTFILE);
   foreach my $i ($min..$max) {
      print "$i: ";
      $| = 1;
      my $t1 = time;
      my $c = doAllTrianglesWithPerimeter($i);
      my $t2 = time;
      my $tstr = formatTiming($t1, $t2);
      $total->badd($c);
      print $c."($total) - $tstr\n";
      open (OUTFILE, '>>'.$fn) or die "could not open $fn for append.\n$!\n";
      print OUTFILE "$i: $c ($total)\n";
      close(OUTFILE);
   }
   my $t_end = time;
   my $tstr_overall = formatTiming($t_start, $t_end);
   open (OUTFILE, '>>'.$fn) or die "could not open $fn for append.\n$!\n";
   print OUTFILE "total: $total (perimeter = $min to $max)\n";
   close(OUTFILE);
   print "Perimeter = $min to $max: There are $total special triangles\n";
   print "Elapsed time: $tstr_overall\n";
}


sub doAllTrianglesWithPerimeter {
   my $p = shift || 1;
   
   my $count = 0;

   my @cur = (1,1,$p-2);
   
   while ($cur[0] <= $cur[2]) {
      while ($cur[1] <= $cur[2]) {
         if ($cur[0] + $cur[1] >= $cur[2] && ($cur[0] * $cur[2] / $cur[1]) % 2 == 0) {
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
   
   
sub formatTiming {
   my $t1 = shift;
   my $t2 = shift;
   my $t = $t2 - $t1;
   my $m = substr('0'.(int($t / 60)), -2);
   my $s = $t - $m * 60;
   if ($s < 10) {
      $s = '0'.$s;
   }
   my $retval = "$m:$s";
   return $retval;
}


