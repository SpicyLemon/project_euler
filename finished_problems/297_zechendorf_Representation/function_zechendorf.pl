#!/usr/bin/perl
################################################################################
# 
# function_zechendorf.pl
# 
# Author:      Danny Wedul
# Date:        June 18, 2010
#              
# Description: Generates the sum of z(n) for 0 > n > <number> 
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

my $target = Math::BigInt->new(0);
if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $target = Math::BigInt->new($1);
}
if (! $target->is_pos()) {
   die "Usage: $0 <number>\n";
}

my @data = (
   { f => Math::BigInt->new(0), t => Math::BigInt->new(0) },
   { f => Math::BigInt->new(1), t => Math::BigInt->new(1) },
   { f => Math::BigInt->new(2), t => Math::BigInt->new(2) },
);

#calculate main totals and needed fibonacci numbers
while ($data[-1]->{f}->bcmp($target) < 0) {
   my $t0 = $data[-1]->{t} + $data[-2]->{t} + $data[-2]->{f} - 1;
   my $f0 = $data[-1]->{f} + $data[-2]->{f};
   
   push (@data, { f => $f0, t => $t0 });   
}

foreach my $d (@data) {
   print substr((' ' x 20).$d->{f}, -20).' | '.$d->{t}."\n";
}
print $data[-2]->{f}.' < '.$target.' < '.$data[-1]->{f}."\n";

my $total = t($target);

print 'n from 1 to '.$target.' has a total of '.$total."\n";


sub t {
   my $n = shift;
   print 't('.$n.'): ';
      
   #get the fibonacci numbers that bracket $n
   my $f0 = 0;    #fibonacci number higher than (or equal to) $n
   my $t0 = 0;    #total up to fibonacci number $f1
   my $f1 = 0;    #fibonacci number less than $n
   my $t1 = 0;    #total up to fibonacci number $f2
   
   my $retval = 0;
   
   foreach my $i (0..$#data) {
      if ($data[$i]->{f} >= $n) {
         print 'i = '.$i.'  ';
         $f0 = $data[$i]->{f};
         $t0 = $data[$i]->{t};
         $f1 = $data[$i-1]->{f};
         $t1 = $data[$i-1]->{t};
         last;
      }
   }
   
   print $f1.' < '.$n.' <= '.$f0.' >> ';
   #if $n is a fibonacci number, we're done
   if ($n == $f0) {
      $retval = $t0;
      print "done: $t0\n";
   }
   #catch an error just in case
   elsif ($n <= 0) {
      print "error: 0\n";
      $retval = 0;
   }
   #otherwise, we've got to do some recursive stuff
   else {
      my $subt = $t1 + $n - $f1;
      my $l = $n - $f1;
      print "recurse $t1 + $n - $f1 + t($l) = $subt + t($l)\n";
      $retval = $subt + t($l);
   }
   
   return $retval;
}
      
   

