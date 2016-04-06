#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;
my $_time_start = time;

my $max = 5;

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
   
   my %cubes_by_digits = ();
   my $found = 0;
   my $cur = 100;
   my $cur_length = 7;
   while (!$found) {
      my $cube = $cur ** 3;
      my $digits = join('', sort split(//, $cube));
      if (! exists $cubes_by_digits{$digits}) {
         $cubes_by_digits{$digits} = [];
      }
      if ($cur_length < length($cube)) {
         $cur_length = length($cube);
         %cubes_by_digits = ();
      }
      push (@{$cubes_by_digits{$digits}}, $cur);
      if (scalar @{$cubes_by_digits{$digits}} >= $max) {
         print Dumper({$digits => $cubes_by_digits{$digits}})."\n";
         $answer = $cubes_by_digits{$digits}->[0];
         $found = 1;
      }
      $cur += 1;
   }
   
   print "Answer: $answer\n";
}






