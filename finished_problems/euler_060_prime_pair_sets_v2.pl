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

my @primes;
my @prime_index_keys;
my %prime_index = ();
my %primes_of_interest = (
   2 => {},
   3 => {},
   4 => {},
   5 => {},
);
my %matches = (
   2 => [],
   3 => [],
   4 => [],
   5 => [],
);
my %already_checked = ();


mainProgram();
my $_time_stop =  time;
my $_elapsed_time = $_time_stop - $_time_start;
print "Elapsed time (seconds): $_elapsed_time\n";
exit(0); 


sub mainProgram {

   my $answer = 0;
   
   prepPrimeStuff();
   
   foreach my $level ((2, 3, 4)) {
      my @primes_to_check = sort { $a <=> $b } keys %{$primes_of_interest{$level}};
      $primes_of_interest{$level} = {};
      print 'Looking for groups of '.($level + 1).' in '
           .(scalar @primes_to_check).' primes, and '
           .(scalar @{$matches{$level}}).' matches of '.$level
           ."\n";
      foreach my $prime (@primes_to_check) {
         foreach my $match (@{$matches{$level}}) {
            if (!myMath::isIn($match, $prime, 1)) {
               my @new_list_to_check = sort { $a <=> $b } (@$match, $prime);
               if (!isAlreadyChecked(\@new_list_to_check)) {
                  checkGroup(\@new_list_to_check, $prime);
               }
            }
         }
      }
   }
   
   foreach my $match (@{$matches{5}}) {
      my $sum = myMath::sum($match);
      print join(' + ', @$match).' = '.$sum;
      if (!$answer || $answer > $sum) {
         $answer = $sum;
      }
   }
   
   print "Answer: $answer\n";
}


sub isMatch {
   my $i = shift;
   my $j = shift;
   my $retval = 0;
   if (isInPrimeList($i.$j) && isInPrimeList($j.$i)) {
      $retval = 1;
   }
   return $retval;
}


sub checkGroup {
   my $list = shift;
   my $new_prime = shift;
   my $retval = 1;
   foreach my $list_prime (@$list) {
      next if $list_prime == $new_prime;
      if (!isMatch($new_prime, $list_prime)) {
         $retval = 0;
         last;
      }
   }
   if ($retval) {
      addMatch($list);
   }
   addChecked($list);
   return $retval;
}


sub addMatch {
   my $list = shift;
   my $level = scalar @$list;
   push (@{$matches{$level}}, $list);
   foreach my $val (@$list) {
      $primes_of_interest{$level}->{$val} = 1;
   }
   my $line = substr('New Set: '.(scalar @$list).' ['.join(', ', @$list).']'.(' ' x 40), 0, 40);
   foreach my $k (sort keys %matches) {
      $line .= "\t".$k.': '.(scalar @{$matches{$k}});
   }
   print $line."\n";
}


sub addChecked {
   my $list = shift;
   my $list_length = scalar @$list;
   if ($list_length >= 1 && ! exists $already_checked{$list->[0]}) {
      $already_checked{$list->[0]} = {};
   }
   if ($list_length >= 2 && ! exists $already_checked{$list->[0]}->{$list->[1]}) {
      $already_checked{$list->[0]}->{$list->[1]} = {};
   }
   if ($list_length >= 3 && ! exists $already_checked{$list->[0]}->{$list->[1]}->{$list->[2]}) {
      $already_checked{$list->[0]}->{$list->[1]}->{$list->[2]} = {};
   }
   if ($list_length >= 4 && ! exists $already_checked{$list->[0]}->{$list->[1]}->{$list->[2]}->{$list->[3]}) {
      $already_checked{$list->[0]}->{$list->[1]}->{$list->[2]}->{$list->[3]} = {};
   }
   if ($list_length >= 5 && ! exists $already_checked{$list->[0]}->{$list->[1]}->{$list->[2]}->{$list->[3]}->{$list->[4]}) {
      $already_checked{$list->[0]}->{$list->[1]}->{$list->[2]}->{$list->[3]}->{$list->[4]} = {};
   }
}


sub isAlreadyChecked {
   my $list = shift;
   my $retval = 1;
   my $list_length = scalar @$list;
   if ($retval && $list_length >= 1 && ! exists $already_checked{$list->[0]}) {
      $retval = 0;
   }
   if ($retval && $list_length >= 2 && ! exists $already_checked{$list->[0]}->{$list->[1]}) {
      $retval = 0;
   }
   if ($retval && $list_length >= 3 && ! exists $already_checked{$list->[0]}->{$list->[1]}->{$list->[2]}) {
      $retval = 0;
   }
   if ($retval && $list_length >= 4 && ! exists $already_checked{$list->[0]}->{$list->[1]}->{$list->[2]}->{$list->[3]}) {
      $retval = 0;
   }
   if ($retval && $list_length >= 5 && ! exists $already_checked{$list->[0]}->{$list->[1]}->{$list->[2]}->{$list->[3]}->{$list->[4]}) {
      $retval = 0;
   }
   return $retval;
}


sub isInPrimeList {
   my $val = shift;
   my $retval = 0;
   my $start_i = 0;
   foreach my $pik (@prime_index_keys) {
      if ($val < $pik) {
         last;
      }
      $start_i = $prime_index{$pik};
   }
   for (my $i = $start_i; $i < $#primes; $i++) {
      if ($primes[$i] == $val) {
         $retval = 1;
         last;
      }
      elsif ($primes[$i] > $val) {
         last;
      }
   }
   return $retval;
}


sub prepPrimeStuff {
   print "Loading Primes.\n";
   @primes = myMath::getPrimesBelow(100000000);
   print "Indexing primes list.\n";
   my $di = int($#primes / 20) + 1;
   my $pi = $di;
   while ($pi < $#primes) {
      $prime_index{$primes[$pi]} = $pi;
      $pi += $di;
   }
   @prime_index_keys = sort { $a <=> $b } keys %prime_index;
   print "Finding primes of interest.\n";
   foreach my $prime (@primes) {
      my $prime_length = length($prime);
      my @splits = $prime_length == 8 ? (4)
                 : $prime_length == 7 ? (3)
                 : $prime_length == 6 ? (2, 3)
                 : $prime_length == 5 ? (1, 2)
                 : $prime_length == 4 ? (1, 2)
                 : $prime_length == 3 ? (1)
                 : $prime_length == 2 ? (1)
                 : ()
                ;
      foreach my $i (@splits) {
         my $first = substr($prime, 0, $i);
         if ($first % 2 == 1) {
            my $last = substr($prime, $i, $prime_length - $i);
            if (substr($last, 0, 1) != '0' && $first < $last && isInPrimeList($first) && isInPrimeList($last) && isInPrimeList($last.$first)) {
               addMatch([$first, $last]);
               addChecked([$first, $last]);
            }
         }
      }
   }
   print "Preperation complete.\n";
}
