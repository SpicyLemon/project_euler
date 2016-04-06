#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;
my $_time_start = time;

my $max = 10000;

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
   
   myMath::initializePrimeList($max);
   
   #start with this:
   #37 36 35 34 33 32 31
   #38 17 16 15 14 13 30
   #39 18  5  4  3 12 29
   #40 19  6  1  2 11 28
   #41 20  7  8  9 10 27
   #42 21 22 23 24 25 26
   #43 44 45 46 47 48 48
   
   my $side_length = 7;
   my $diag_prime = 8;  #3 13 31 5 17 37 7 43
   my $diag_count = $side_length * 2 - 1;
   my $ratio = $diag_prime / $diag_count;
   while ($ratio >= .10) {
      $side_length += 1;
      my @corners = (($side_length + 1) ** 2);
      foreach my $i (0..2) {
         push (@corners, $corners[$i] - $side_length);
      }
      $side_length += 1;
      $diag_count += 4;
      foreach my $d (@corners) {
         $diag_prime += 1 if (myMath::isPrime($d));
      }
      $ratio = $diag_prime / $diag_count;
      print substr((' ' x 10).$side_length, -10).': '.$ratio."\n";
   }
   $answer = $side_length;
      

         
      
   
   
   print "Answer: $answer\n";


}






