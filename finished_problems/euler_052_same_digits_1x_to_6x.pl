#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;


my $start = 10;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $start = $1;
}




mainProgram();
exit(0); 



sub mainProgram {

   my $total = 0;
   
   my $x = $start;
   while ($total == 0) {
      my $sx = join('', sort split(//, ($x)));
      my $isgood = 1;
      #print "$x ($sx)\t";
      foreach my $i (2..6) {
         my $v = $i * $x;
         my $sv = join('', sort split(//, ($v)));
         #print "$v ($sv)\t";
         if ($sv ne $sx) {
            $isgood = 0;
            last;
         }
         else {
            #print "($v) $sv eq $sx\n";
         }
         if ($i == 5) {
            #print "$x is close!\n";
         }
      }
      print "\n";
      if ($isgood) {
         $total = $x;
      }
      else {
         $x += 1;
      }
   }

   foreach my $i (1..6) {
      print "x * $i = ".($x * $i)."\n";
   }
   print "answer: $total\n";



}







