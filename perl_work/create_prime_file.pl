#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;

my $fn = 'primes.txt';

my $max = '100000000'; #100 million

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}

#last I knew, the largest in there was the next one over 100 million (100,000,000).

mainProgram();
exit(0); 



sub mainProgram {

   print "Making sure all primes below $max are in $fn.\n";
   myMath::initializePrimeList($max);
   print "all primes below ".$myMath::primes[-1]." are in $fn.\n";
   
}






