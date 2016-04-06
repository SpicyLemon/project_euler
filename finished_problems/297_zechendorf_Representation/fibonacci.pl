#!/usr/bin/perl
################################################################################
# 
# fibonacci.pl
# 
# Author:      Danny Wedul
# Date:        June 18, 2010
#              
# Description: Generates fibonacci numbers
#              
# Usage:       fibonacci.pl <max length>
#                 where <max length> is the max number of digits you want
#                 if omitted, 100 will be used
#              
# Revisions:   
#              
################################################################################
use strict;
use warnings;
use Math::Bigint;

use easyopen qw(openr openread openw openwrite opena openappend slurpFile);


my $storage_file = 'fibonacci.txt';

my $f2 = "1";
my $f1 = "1";

my $max_len = 100;
if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max_len = $1;
}


my $FF = undef;

if (! -e $storage_file) {
   $FF = openwrite($storage_file);
   print $FF "$f2\n";
   print $FF "$f1\n";
   close($FF);
   print "1\n1\n";
}
else {
   $FF = openread($storage_file);
   $f1 = <$FF>;
   chomp $f1;
   print "$f1\n";
   while (my $line = <$FF> && length($f1) <= $max_len) {
      $f2 = $f1;
      $f1 = $line;
      chomp $f1;
      print $line;
   }
   close($FF);
}

if (length($f1) <= $max_len) {
   $f2 = Math::BigInt->new($f2);
   $f1 = Math::BigInt->new($f1);
   $FF = openappend($storage_file);
   while (scalar $f1->length() <= $max_len) {
      my $f0 = $f1 + $f2;
      $f2 = $f1;
      $f1 = $f0;
      print $FF $f0."\n";
      print $f0."\n";
   }
   close($FF);
}
