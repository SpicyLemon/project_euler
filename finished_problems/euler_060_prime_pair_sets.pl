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
prepPrimeStuff();


my %matches = (
   2 => [],
   3 => [],
   4 => [],
   5 => [],
);

#testProgram();
mainProgram();
my $_time_stop =  time;
my $_elapsed_time = $_time_stop - $_time_start;
print "Elapsed time (seconds): $_elapsed_time\n";
exit(0); 


sub testProgram {
   my @l = (1, 2, 3, 4, 88, 10);
   print '['.join(', ', @l).'] => '.myMath::sum(@l)."\n";
   foreach my $v (@l) {
      if (isInPrimeList($v)) {
         print "$v is in the primes list.\n";
      }
   }
}


sub mainProgram {

   my $answer = 0;
   
   print "Looking for groups of $max\n";
   
   for(my $i = 1; $primes[$i] <= 9999; $i++) {
      print "Checking out ".$primes[$i]."\n";
      for(my $j = 1; $j < $i; $j++) {
         if (my $winner = isSuccess($primes[$i], $primes[$j])) {
            my $sum = myMath::sum($winner);
            print '['.join(', ', sort {$a <=> $b } @$winner).'] => '.$sum."\n";
            if (!$answer || $sum < $answer) {
               $answer = $sum;
            }
         }
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


sub isSuccess {
   my $i = shift;
   my $j = shift;
   
   my $retval = undef;
   
   if (isMatch($i, $j)) {
      foreach my $level ((4, 3, 2)) {
         foreach my $existingMatch (@{$matches{$level}}) {
            if (myMath::isIn($existingMatch, $j)) {
               my $all_good = 1;
               foreach my $existingMatchVal (@$existingMatch) {
                  if (!isMatch($existingMatchVal, $i)) {
                     $all_good = 0;
                     last;
                  }
               }
               if ($all_good) {
                  my @new_list = ();
                  foreach my $existingMatchVal (@$existingMatch) {
                     push(@new_list, $existingMatchVal);
                  }
                  push (@new_list, $i);
                  addMatch(\@new_list);
                  if (scalar @new_list >= $max) {
                     $retval = \@new_list;
                  }
               }
            }
         }
      }
      addMatch([$i, $j]);
   }
   
   return $retval;
}


sub addMatch {
   my $list = shift;
   my @new_list = sort {$a <=> $b} @$list;
   my $level = scalar @new_list;
   my $is_new = 1;
   foreach my $match (@{$matches{$level}}) {
      if (isSameList(\@new_list, $match)) {
         $is_new = 0;
         last;
      }
   }
   if ($is_new) {
      push (@{$matches{scalar @new_list}}, \@new_list);
      my $line = substr('New Set: '.(scalar @new_list).' ['.join(', ', @new_list).']'.(' ' x 40), 0, 40);
      foreach my $k (sort keys %matches) {
         $line .= "\t".$k.': '.(scalar @{$matches{$k}});
      }
      print $line."\n";
   }
}


sub isSameList {
   my $list_a = shift;
   my $list_b = shift;
   my $retval = 0;
   if (scalar @$list_a == scalar @$list_b) {
      $retval = 1;
      for(my $i = 0; $i <= $#$list_a; $i++) {
         if ($list_a->[$i] != $list_b->[$i]) {
            $retval = 0;
            last;
         }
      }
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
   print "Preperation complete.\n";
}
