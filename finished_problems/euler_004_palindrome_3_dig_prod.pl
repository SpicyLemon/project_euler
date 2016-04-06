#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

mainProg();

sub mainProg {
   my @pp = ();
   foreach my $i (100..999) {
      foreach my $j (100..999) {
         my $k = $i * $j;
         push (@pp, $k) if (isPalindrome($k));
      }
   }
   @pp = sort { $a <=> $b } @pp;
   print $pp[-1]."\n";
   print Dumper(\@pp)."\n";
}

#usage: if (isPalindrome($v)) {...}
sub isPalindrome {
   my $f = shift || '';
   $f .= '';
   my $g = join('', reverse split(//, $f));
   my $retval = ( $f eq $g ) ? 1 : 0 ;
   return $retval;
}

