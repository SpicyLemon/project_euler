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

my @factorial = (1);

foreach my $i (1..9) {
   my $f = $factorial[-1] * $i;
   push (@factorial, $f);
}

my %next_number = ();



mainProgram();
my $_time_stop =  time;
my $_elapsed_time = $_time_stop - $_time_start;
print "Elapsed time (seconds): $_elapsed_time\n";
exit(0); 



sub mainProgram {

   my $answer = 0;
   
   print "Going through the first $max starting numbers\n";
   foreach my $i (1..$max) {
      my @last3 = (0,0,$i);
      foreach my $j (1..65) {
         my $n = getNext($last3[2]);
         my $stopper = 0;
         foreach my $k (0..$#last3) {
            if ($last3[$k] == $n) {
               if ($j - $k == 60) {
                  $answer += 1;
                  print "$i: $j - ".join(' ' , @last3)." $n\n";
               }
               $stopper = 1;
               last;
            }
         }
         last if $stopper;
         shift @last3;
         push (@last3, $n);
      }
   }
               
   print "Answer: $answer\n";


}


sub getNext {
   my $in = shift || '1';
   
   my $retval = '1';
   if (exists $next_number{$in}) {
      $retval = $next_number{$in};
   }
   else {
      $retval = calculateNext($in);
      $next_number{$in} = $retval;
   }
   return $retval;
}


sub calculateNext {
   my $in = shift || '1';
   
   my $retval = 0;
   foreach my $d (split(//, $in)) {
      $retval += $factorial[$d];
   }
   
   return $retval;
}


