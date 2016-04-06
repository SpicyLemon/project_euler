#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my @f = (1, 1);

while ($f[-1] <= 4000000) {
   push (@f, $f[-1] + $f[-2]);
}

pop (@f);

my $total = 0;
foreach my $v (@f) {
   if ($v % 2 == 0) {
      $total += $v;
   }
}

print $total."\n";
print Dumper(@f)."\n";

