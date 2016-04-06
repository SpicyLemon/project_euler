#!/usr/bin/perl
use strict;
use warnings;
#use Math::BigInt;
#use Math::BigFloat;
use Data::Dumper;
use lib qw(.);
use myMath;
use Prompt;
my $_time_start = time;

my $max = 1;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}

my $min = 1;
my $num = 15499;
my $den = 94744;
my $debug = 0;
if ($max == 1) {
   $num = 4;
   $den = 10;
   $debug = 1;
}
elsif ($max == 2) {
   $debug = 1;
}
$max = $num/$den;

myMath::initializePrimeList(1000000);

if ($debug) {
   print join("\t", ('test', 'divs', 'num', 'den', 'f', 'max', 'answer'))."\n";
}

#testProgram();
mainProgram();
my $_time_stop =  time;
my $_elapsed_time = $_time_stop - $_time_start;
print "Elapsed time (seconds): $_elapsed_time\n";
exit(0); 


sub testProgram {
   my $to_test = 1;
   my $min = 1;
   my $answer = 0;
   while ($to_test) {
      $to_test = prompt("Value");
      if ($to_test) {
         checkForAnswer($to_test, 1);
      }
   }
   
}

sub mainProgram {

   my $answer = 0;
   
   my $to_test = 1;
   my @factors = (2, 3, 5, 7, 11, 13, 17, 19, 23);
   my @next_factors = ( 
      [3], [2, 2], [5], [2, 3], [7], [2, 2, 2], 
      [3, 3], [2, 5], [11], [2, 2, 3], [13], [2, 7], [3, 5], [2, 2, 2, 2],
      [17], [2, 3, 3], [19], [2, 2, 5], [3, 7], [2, 11], [23], [2, 2, 3, 3],
      [5, 5], [2, 13], [3, 3, 3], [2, 2, 7], [29],
   );
   foreach my $additional_factors (@next_factors) {
      print myMath::product($additional_factors)."\n";
      my @all_factors = (@factors, @$additional_factors);
      $answer = checkForAnswer(\@all_factors, 1);
      if ($answer) {
         last;
      }
   }
   print "Answer: $answer\n";
}


sub checkForAnswer {
   my $param = shift;
   my $do_not_pause = shift;
   my $val = 1;
   my $factors = [];
   if (ref $param) {
      $factors = $param;
      $val = myMath::product($factors);
      if ($debug) {
         print "given array.\n"
              ."val: $val\n"
              ."factors: ".join(', ', @$factors)."\n";
      }
   }
   else {
      $val = $param;
      $factors = myMath::factor($val);
      if ($debug) {
         print "given val.\n"
              ."val: $val\n"
              ."factors: ".join(', ', @$factors)."\n";
      }
   }
   my $retval = 0;
   my $div_count = countReducableFractions($factors);
   my $new_num = $val - $div_count - 1;
   my $new_den = $val - 1;
   my $f = $new_num / $new_den;
   if ($f < $min) {
      $min = $f;
      print "New min: $val => $new_num / $new_den = $min\n";
   }
   if ($f < $max) {
      $retval = $val;
   }
   if ($debug) {
      print join("\t", ($val, $div_count, $new_num, $new_den, substr($f, 0, 7), substr($max, 0, 7), $retval));
      if ($do_not_pause) {
         print "\n";
      }
      else {
         my $tosser = <STDIN>;
      }
   }
   
   return $retval;
}


sub countReducableFractions {
   my $param = shift;
   my $val = 1;
   my $factors = [];
   if (ref $param) {
      $factors = $param;
      $val = myMath::product($factors);
   }
   else {
      $val = $param;
      $factors = myMath::factor($val);
   }
   my @answers = ();
   my $retval = 0;
   for(my $i = 2; $i < $val; $i++) {
      if (!isRelativelyPrime($i, $factors)) {
         $retval += 1;
         if ($debug && $retval < 100) {
            push (@answers, $i);
         }
      }
   }
   if ($debug && $retval < 100) {
      print join(", ", sort { $a <=> $b } @answers)."\n";
   }
   return $retval;
}


sub isRelativelyPrime {
   my $val1 = shift;;
   my $factors2 = shift;
   my $retval = 1;
   foreach my $factor (@$factors2) {
      if ($val1 % $factor == 0) {
         $retval = 0;
         last;
      }
   }
   return $retval;
}

my $notes = q|
     4: 2 2
     6: 2        3
    12: 2 2      3
    18: 2        3 3
    24: 2 2 2    3
    30: 2        3      5
    60: 2 2      3      5
    90: 2        3 3    5
   120: 2 2 2    3      5
   150: 2        3      5 5
   180: 2 2      3 3    5
   210: 2        3      5    7
   420: 2 2      3      5    7
   630: 2        3 3    5    7
   840: 2 2 2    3      5    7
  1050: 2        3      5 5  7
  1260: 2 2      3 3    5    7
  1470: 2        3      5    7 7
  1680: 2 2 2 2  3      5    7
  1890: 2        3 3 3  5    7
  2100: 2 2      3      5 5  7
  2310: 2        3      5    7    11
  4620: 2 2      3      5    7    11
  6930: 2        3 3    5    7    11
  9240: 2 2 2    3      5    7    11
 11550: 2        3      5 5  7    11
 13860: 2 2      3 3    5    7    11
 16170: 2        3      5    7 7  11
 18480: 2 2 2 2  3      5    7    11
 20790: 2        3 3 3  5    7    11
 23100: 2 2      3      5 5  7    11
 25410: 2        3      5    7    11 11
 27720: 2 2 2    3 3    5    7    11
 30030: 2        3      5    7    11     13
 60060: 2 2      3      5    7    11     13
 90090: 2        3 3    5    7    11     13
120120: 2 2 2    3      5    7    11     13
150150: 2        3      5 5  7    11     13
180180: 2 2      3 3    5    7    11     13
210210: 2        3      5    7 7  11     13

510510: 2 3 5 7 11 13 17

9699690: 2 3 5 7 11 13 17 19 => 2^12 * 3^4 * 5 / n-1
19 is line 8, 23 is line 9.
9699667 is line 646033. 9699713 is line 646034
That's 646025 primes over 19 but less than 9699690

174594420: 2 2 3 3 3 5 7 13 17 19: 29859840 / 174594419 = 0.17102



223092870: 2 3 5 7 11 13 17 19 23: 36495360 / 223092869 = .163588

446185740 => 72990720 / 446185739 = 0.16358819572223

892371480.  That's it.

                      0.16358819572223037814303607762775
                                 ^
Looking for less than 0.16358819555855779785527315713924


Idea: start with n = 2 3 5 7 11 13 17 19 23
The next lowest is n*2, then n*3, ... n*29 (29 being the next prime).
Then, to get the number of non-reducable fractions...
   Get all the primes bigger than 23, and less than the number being tested.
   Any value that has only those as factors isn't reducable.
   So, start with 1 factor (the primes)
   Then go on to two factors.
      for two, start with the smallest * smallest, then smallest * next and so on, until that's larger than the number being tested.
      Then move on to the next smallest * next smallest and so on until the first number squared is more than the number being tested.
   Then go on to three factors.
      and so on until the smallest prime, to the power of the number of factors in question, is more than the number being tested.
      
My guess is that it's less than 2 3 5 7 11 13 17 19 23 29. But who knows.
|;
