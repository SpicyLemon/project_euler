#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;


my $pd = '123456789';


mainProgram();
exit(0); 

sub mainProgram {

   my $total = 0;
   
   my $min = '918273645';
   my $max = '987654321';
   
   foreach my $i (1..5) {

      foreach my $i (reverse(substr($min, 0, $i)..substr($max, 0, $i))) {
         next if (! allDifferent($i));
         my $str = $i;
         my $j = 2;
         while (length($str) < 9) {
            my $ii = $i * $j;
            $str .= $ii;
            $j += 1;
         }
         if (length($str) == 9 && isPandigital($str)) {
            if ($str > $total) {
               print "$i: $str\n";
               $total = $str;
            }
            last;
         }
      }
   }   

   print "$total\n";

}

sub mainProgram2 {

   my $total = 0;
   
   my $v = 987654321;
   while ($v >= 918273645) {
      if (isPandigital($v)) {
         #print "checking $v\n";
         foreach my $j (1..5) {
            my $i = substr($v, 0, $j); #the integer!
            my $ii = 2;    #the next multiplier
            my $str = $i;
            while (length($str) < 9) {
               my $iii = $i * $ii;
               $str .= $iii;
               $ii += 1;
            }
            if ($str eq $v) {
               print "$str\n";
            }
         }
      }
      $v -= 1;
   }
   
   
   print "$total\n";


}


sub isPandigital {
   my $q = shift || '1';
   return (join('', sort split(//, $q)) eq $pd) ? 1 : 0;
}

sub allDifferent {
   my $q = shift || 1;
   my %used = ();
   my $retval = 1;
   foreach my $i (1..length($q)) {
      my $j = substr($q, $i-1, 1);
      if (exists $used{$j}) {
         $retval = 0;
         last;
      }
   }
   return $retval;
}


