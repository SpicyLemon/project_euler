#!/usr/bin/perl
################################################################################
# 
# function_zechendorf.pl
# 
# Author:      Danny Wedul
# Date:        June 18, 2010
#              
# Description: Generates the sum of z(n) for 0 > n > 10^? 
#                 z(n) = the number of fibonacci numbers used in the
#                    zechendorf representation of n
#              
# Usage:       function_zechendorf.pl <number>
#              
# Revisions:   
#              
################################################################################
use strict;
use warnings;
use Math::BigInt;

use easyopen qw(openr openread openw openwrite opena openappend slurpFile);


my $target = 10;
if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $target = Math::BigInt->new($1);
}

my @fibs = (Math::BigInt->new(1), Math::BigInt->new(2));
while ($fibs[-1] < $target) {
   push (@fibs, $fibs[-1] + $fibs[-2]);
}
print join("\n", @fibs)."\n";

@fibs = reverse(@fibs);


my $total = Math::BigInt->new(0);
my $start = Math::BigInt->new(0);

for (my $i = $start; $i <= $target; $i->binc()) {
   my @znums = zout($i);
   $total += scalar(@znums);
   if ($#znums == 0) {
      print $i.' : '.$total."\n";
   }
   if ($i == $target) {
      print $target.' = '.join(' + ', @znums)."\n";
   }
}

print "n from $start to $target has a total of $total\n";



sub zout {
   my $n = shift;
   my @retval = ();
   
   foreach my $f (@fibs) {
      if ($f <= $n) {
         push(@retval, $f);
         $n = $n - $f;
      }
   }
   
   return @retval;
}


