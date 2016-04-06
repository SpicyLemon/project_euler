#!/usr/bin/perl
################################################################################
# 
# easy_zechendorf.pl
# 
# Author:      Danny Wedul
# Date:        June 18, 2010
#              
# Description: Generates the sum of z(n) for 0 > n > 10^? 
#                 z(n) = the number of fibonacci numbers used in the
#                    zechendorf representation of n
#              
# Usage:       easy_zechendorf.pl <max length>
#              
# Revisions:   
#              
################################################################################
use strict;
use warnings;
use Math::BigInt;

use easyopen qw(openr openread openw openwrite opena openappend slurpFile);

my $f2 = Math::BigInt->new(1);
my $t2 = Math::BigInt->new(1);

my $f1 = Math::BigInt->new(2);
my $t1 = Math::BigInt->new(2);
                               #12345678901234567
my $target = Math::BigInt->new(1000000);  #10^6

while ($f1->bcmp($target) < 0) {
   my $t0 = $t1 + $t2 + $f2 - 1;
   my $f0 = $f1 + $f2;
   
   $t2 = $t1;
   $t1 = $t0;
   
   $f2 = $f1;
   $f1 = $f0;
   
   print substr((' ' x 20).$f1, -20).' | '.$t1."\n";
}
print $f2."\n";
print $target."\n";
print $f1."\n";


