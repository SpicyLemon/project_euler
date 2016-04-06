#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
use myMath;

my %counts = (
   0 => 0
);
 
my $amount = 10;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $amount = $1;
}
   
my @start_coins = (1..($amount -1));


mainProgram();
exit(0); 



sub mainProgram {

   my $total = 0;
   
   #count the 1 coin options, and get rid of any coins we won't need
   my @coins = ();
   foreach my $coin (@start_coins) {
      if ($amount % $coin == 0) {
         $total += 1;
      }
      if ($coin < $amount) {
         push (@coins, $coin);
      }
      else {
         last;
      }
   }
   
   print "Counting coin combos that total $amount\n";
   print "Using only these coins: (".join(', ', @coins).")\n";
   if (grep {$_ eq $amount} @start_coins) {
      print "The $amount coin is counted, but isn't needed for any other calculations.\n";
   }
   print "There are $total single coin options.\n";
   
   foreach my $i (2..($#coins+1)) {
      my $groups = myMath::getGroups(\@coins, $i);
      my $subtotal = 0;
      foreach my $group (@$groups) {
         $subtotal += countCombos($amount, $group);
      }
      print "There are $subtotal combinations of $i coins\n";
      $total += $subtotal;
   }
   
   print "total = $total\n";
}


sub countCombos {
   my $val = shift || 0;
   my $c = shift || [];
   my $d = shift || 0;
   
   my @coins = sort { $a <=> $b } @$c;

   my $retval = 0;
   
   if ($#coins < 0) {
      print "error in countCombos call, no coins given, val = $val\n";
   }
   elsif ($#coins == 0) {
      #shouldn't ever really get here, but just in case.
      if ($val % $coins[0] == 0) {
         $retval = 1;
      }
   }
   elsif ($#coins == 1) {
      #count the number of combos there are involving both coins
      my $bcm = $coins[1];
      while ($bcm < $val) {
         if (($amount - $bcm) % $coins[0] == 0) {
            $retval += 1;
         }
         $bcm += $coins[1];
      }
   }
   else {
      #print ''.(' ' x ($d * 3))."$val: (".join(',', @coins).")\n";
      
      #using all the given coins:
      my @all_coins = ();
      foreach my $coin (@coins) {
         push (@all_coins, $coin);
      }
      my $big_coin = pop(@all_coins);
      my $bcm = $big_coin;
      while ($bcm < $val) {
         $retval += countCombos($val-$bcm, \@all_coins, $d+1);
         $bcm += $big_coin;
      }      
   }
   
   #print ''.(' ' x ($d * 3))."$val: (".join(',', @coins).") = $retval\n";

   return $retval;
}

