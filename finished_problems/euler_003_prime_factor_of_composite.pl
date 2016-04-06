#!/usr/bin/perl
use strict;
use warnings;

my $v = 600851475143;
$v = 8462696833;
$v = 10086647;

my $i = 71;
$i = 839;

mainProg();

sub mainProg {
   while (1) {
      if (isPrime($i)) {
         print $i." :";
         foreach my $j (1..9) {
            print ' '.($i*$j).' ';
         }
         if ($v % $i == 0) {
            print "!!!!!!!!!!!!!!!!!!!";
            my $x = <STDIN>;
         }
         print "\n";
      }
      $i += 2;
   }
}

# usage: if (isPrime($v)) {...}
sub isPrime {
   my $f = shift || 4;
   my $retval = 1;
   foreach my $j (2..int($f/2)) {
      if ($f % $j == 0) {
         $retval = 0;
         last;
      }
   }
   return $retval;
}



