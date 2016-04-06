#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;
my $_time_start = time;

my $min = 56003;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $min = $1;
}

my @combinations = ();

#testProgram(); 
mainProgram();
my $_time_stop =  time;
my $_elapsed_time = $_time_stop - $_time_start;
print "Elapsed time (seconds): $_elapsed_time\n";
exit(0); 

sub testProgram {
   my $val = 56003;
   print 'val: '.$val."\n";
   my @ds = split('', $val);
   my $dc = getDigitCounts(\@ds);
   foreach my $d (sort keys %$dc) {
      my $di = getDigitIndexes(\@ds, $d);
      print $d.' => '.$dc->{$d}.' => ['.join(', ', @$di)."]\n";
   }
   print 'digit masks: '.Dumper(getDigitMasks($val))."\n";
}

sub mainProgram { 
   my $answer = 0;

   my $primes = getPrimesOfInterest();
   my $mask_count = maskAndHash($primes);
   foreach my $mask (keys %$mask_count) {
      if ($mask_count->{$mask} >= 8) {
         print $mask."\n";
      }
   }
   
   print "Answer: $answer\n";
}


sub maskAndHash {
   my $primes = shift;
   my %mask_count = ();
   foreach my $val (@$primes) {
      foreach my $mask (@{getDigitMasks($val)}) {
         if (! exists $mask_count{$mask}) {
            $mask_count{$mask} = 1;
         }
         else {
            $mask_count{$mask} += 1;
         }
      }
   }
   return \%mask_count;
}


sub getDigitMasks {
   my $val = shift;
   my @retval = ();
   my @digits = split('', $val);
   my $digit_counts = getDigitCounts(\@digits);
   foreach my $d (keys %$digit_counts) {
      if ($digit_counts->{$d} <= 1) {
         #print "Ignoring $d\n";
      }
      else {
         #print "looking at $d\n";
         my $digit_indexes = getDigitIndexes(\@digits, $d);
         my $n = scalar @$digit_indexes;
         for(my $k = 2; $k <= $digit_counts->{$d}; $k++) {
            my $groups = getCombinations($n, $k);
            #print 'groups: '.Dumper($groups)."\n";
            foreach my $group (@$groups) {
               #print 'group: '.join(', ', @$group)."\n";
               my $h = $val;
               foreach my $group_i (@$group) {
                  substr($h, $digit_indexes->[$group_i], 1, 'x');
                  #print '$h: '.$h."\n";
               }
               push (@retval, $h);
            }
         }
      }
   }
   return \@retval;
}


sub getDigitCounts {
   my $digits = shift;
   my %retval = ();
   foreach my $d (@$digits) {
      if (! exists $retval{$d}) {
         $retval{$d} = 1;
      }
      else {
         $retval{$d} += 1;
      }
   }
   return \%retval;
}


sub getDigitIndexes {
   my $digits = shift;
   my $digit = shift;
   my @retval = ();
   for (my $i = 0; $i < scalar @$digits; $i++) {
      if ($digits->[$i] == $digit) {
         push (@retval, $i);
      }
   }
   return \@retval;
}


sub getCombinations {
   my $n = shift;
   my $k = shift;
   my $retval = [];
   if ($n >= 1 && $k >= 1 && $n >= $k) {
      if (!defined $combinations[$n]) {
         $combinations[$n] = [];
      }
      if (!defined $combinations[$n]->[$k]) {
         $combinations[$n]->[$k] = myMath::getGroups([0..($n-1)], $k);
      }
      $retval = $combinations[$n]->[$k];
   }
   return $retval;
}


sub getPrimesOfInterest {
   my $min_dig = length($min);
   my $max_dig = $min_dig;
   my $max = 10 ** ($max_dig) - 1;
   
   my @retval = myMath::getPrimesBelow($max);
   my $min_i = 0;
   while ($retval[$min_i] < $min) {
      $min_i += 1;
   }
   splice (@retval, 0, $min_i);
   if ($retval[-1] > $max) {
      pop @retval;
   }
   
   print 'min: '.substr('          '.$min, -10)."\n";
   print 'max: '.substr('          '.$max, -10)."\n";
   print 'primes in range: '.(scalar @retval)."\n";   
   
   return \@retval;
}




