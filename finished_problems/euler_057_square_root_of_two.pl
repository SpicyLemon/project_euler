#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;
my $_time_start = time;

my $max = 10;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}




mainProgram();
my $_time_stop =  time;
my $_elapsed_time = $_time_stop - $_time_start;
print "Elapsed time (seconds): $_elapsed_time\n";
exit(0); 



sub mainProgram {

   my $answer = 0;
   
   my $i = 1;
   my $top = Math::BigInt->new(3);
   my $bottom = Math::BigInt->new(2);
   #print "$i = $top / $bottom\n";
   while ($i <= $max) {
      my $newbottom = $top->copy()->badd($bottom);
      my $newtop = $newbottom->copy()->badd($bottom);
      $top = $newtop;
      $bottom = $newbottom;
      my $lt = length($top);
      my $lb = length($bottom);
      $i += 1;
      if ($lt > $lb) {
         $answer += 1;
      }
      #print "$i: $answer: ($lt / $lb): $top / $bottom\n";
   }
   
   print "Answer: $answer\n";


}






