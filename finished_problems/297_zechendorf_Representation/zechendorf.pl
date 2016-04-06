#!/usr/bin/perl
################################################################################
# 
# zechendorf.pl
# 
# Author:      Danny Wedul
# Date:        June 18, 2010
#              
# Description: calculates zechendorf numbers, and some totals and stuff
#              
# Usage:       zechendorf.pl
#              
# Revisions:   
#              
################################################################################
use strict;
use warnings;
use Math::BigInt;

use easyopen qw(openr openread openw openwrite opena openappend slurpFile);

my $target = undef;
if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $target = ''.$1;
}

my $DEBUG = 0;

my $storage_file = 'fibonacci.txt';
my $z_file = 'zechendorf.txt';

my @fibs = ();

#get a list of all fibonacci numbers that are 17 digits or less.
my $FF = openread($storage_file);
my $keep_going = 1;
while($keep_going) {
   my $line = <$FF>;
   chomp $line;
   push (@fibs, Math::BigInt->new($line));
   if (length($fibs[-1]) > 17) {
      $keep_going = 0;
   }
}
close ($FF);

print join("\n", @fibs)."\n-----------\n" if ($DEBUG);

my $start_point = Math::BigInt->new(2);
                                  #12345678901234567
my $end_point = Math::BigInt->new(100000000000000000); #10^17
if ($target) {
   $end_point = Math::BigInt->new($target);
}

my @cur_list = (
   Math::BigInt->new(1),
);
my $total = 1;

my $i = undef;
my $last_tot = 1;
for (my $i = $start_point; $i <= $end_point; $i->binc()) {
   #add 1 to the current list
   print "$i\n" if ($DEBUG);
   @cur_list = simplify_list(\@cur_list, Math::BigInt->new(1));
   $total += scalar @cur_list;
   if ($#cur_list == 0) {
      my $diff = $total - $last_tot;
      $last_tot = $total;
      print substr((' ' x 17).$i, -17).' '.$total.' => +'.$diff."\n";
   }
}

print $end_point.' = '.join(' + ', @cur_list)."\n";

print "n from 1 to $end_point has a total of $total.\n";

exit(0);




sub simplify_list {
   my $old = shift;
   my $new = shift;
   my @given = (@$old, $new);
   print 'given: '.join(' ', @given)."\n" if ($DEBUG);
   my @retval = ();
   
   my $l1 = pop(@given);
   my $l2 = pop(@given);
   
   my $keep_going = 1;
   print " initial l: $l1 $l2\n" if ($DEBUG);
   while ($keep_going) {
      if (should_combine($l1, $l2)) {
         $l1->badd($l2);
         print '   combined: ' if ($DEBUG);
      }
      else {
         unshift(@retval, $l1->copy());
         $l1 = $l2->copy();
         print '      moved: ' if ($DEBUG);
      }
      $| = 1;
      $l2 = pop(@given) || 'undef';
      print "l: $l1 $l2 || retval: ".join(' ', @retval).' || given: '.join(' ', @given)."\n" if ($DEBUG);
      if ($l2 eq 'undef') {
         $keep_going = 0;
      }
   }
   
   unshift(@retval, $l1);
   print 'returning: '.join(' ', @retval)."\n" if ($DEBUG);
   return @retval;
}


sub should_combine {
   my $f2 = shift;
   my $f1 = shift;
   
   print "f1: $f1 f2: $f2   " if ($DEBUG);
   my $retval = 0;
   
   if ($f2 == $f1) {
      $retval = 1;
      print "equal\n" if ($DEBUG);
   } else {
      print "not equal  " if ($DEBUG);
      foreach my $i (0..$#fibs) {
         if ($fibs[$i] == $f1) {
            if ($f2 == $fibs[$i-1]) {
               print " but they are consecutive\n" if ($DEBUG);
               $retval = 1;
            }
            else {
               print " not consecutive\n" if ($DEBUG);
            }
            last;
         }
      }
   }
   
   return $retval;
}





