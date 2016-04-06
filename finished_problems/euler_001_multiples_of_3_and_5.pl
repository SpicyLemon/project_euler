#!/usr/bin/perl
use strict;
use warnings;

my $total = 0;

foreach my $i (1..999) {
   if ($i % 3 == 0 || $i % 5 == 0) {
      $total += $i;
   }
}

print $total."\n";

