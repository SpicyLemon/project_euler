#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;





mainProgram();
exit(0); 



sub mainProgram {

   my @ab = ();
   my %no_sums = ();

   #find all the abundant numbers
   #and initialize no_sums
   foreach my $i (1..28123) {
      my $s = myMath::sumPropDivs($i);
      if ($i == 12 || $i == 28 || $i % 1000 == 0) { print "$i: $s\n"; }
      if ($s > $i) {
         push (@ab, $i);
      }
      $no_sums{$i} = 1;
   }
   open (OUTFILE, '>abundant_numbers.txt') or die "Could not open abundant_numbers.txt for writing.\n$!\n";
   print OUTFILE Dumper(\@ab);
   close(OUTFILE);

   print "Marking off sums\n";
   foreach my $i (0..$#ab) {
      foreach my $j (0..$#ab) {
         my $s = $ab[$i] + $ab[$j];
         #remove this sum from the no_sums list
         if (exists $no_sums{$s}) {
            delete $no_sums{$s};
         }
      }
   }
   open (OUTFILE, '>no_sums.txt') or die "Could not open no_sums.txt for writing.\n$!\n";
   print OUTFILE Dumper(\%no_sums);
   close(OUTFILE);

   my $total = 0;
   foreach my $k (keys %no_sums) {
      $total += $k;
   }

   print $total."\n";

   

}






