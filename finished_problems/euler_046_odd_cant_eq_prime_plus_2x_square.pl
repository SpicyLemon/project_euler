#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;


my $max = 10000;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}

my @ttsqs = (); #two times squares
my %prime = (); #a hash of primes


mainProgram();
exit(0); 



sub mainProgram {

   my $total = 0;
   
   prepPrimeHash();
   populateTTS();
   
   my $i = 3;
   while ($i <= $max) {
      my $has_one = 0;
      foreach my $tts (@ttsqs) {
         last if ($tts > $i);
         my $p = $i - $tts;
         if (exists $prime{$p}) {
            $has_one = 1;
            last;
         }
      }
      if (!$has_one) {
         $total = $i;
         $i = $max + 1;
      }
      $i += 2;
   }
   
   print "$total\n";


}



sub populateTTS {
   my $ttsmax = int(sqrt($max/2)) + 1;
   if (scalar @ttsqs < $max) {
      @ttsqs = ();
      foreach my $i (0..$max) {
         push (@ttsqs, 2 * $i * $i);
      }
   }
   return 1;
}

sub prepPrimeHash {
   myMath::initializePrimeList($max);
   foreach my $p (@myMath::primes) {
      $prime{$p} = 1;
   }
   @myMath::primes = ();
   return 1;
}
