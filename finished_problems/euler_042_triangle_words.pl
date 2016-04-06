#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;

my $fn = 'words.txt';

my %score = (
   A =>  1, B =>  2, C =>  3, D =>  4, E =>  5,
   F =>  6, G =>  7, H =>  8, I =>  9, J => 10,
   K => 11, L => 12, M => 13, N => 14, O => 15,
   P => 16, Q => 17, R => 18, S => 19, T => 20,
   U => 21, V => 22, W => 23, X => 24, Y => 25, Z => 26,
);

mainProgram();
exit(0); 



sub mainProgram {

   my $total = 0;
   
   my $INFILE = undef;
   open ($INFILE, $fn) or die "Could not open $fn for reading\n$!\n";
   my $contents = '';
   while (my $line = <$INFILE>) {
      $contents .= $line;
   }
   close($INFILE);
   
   $contents =~ s/\s//g;
   $contents =~ s/\"//g;
   my @words = split(/,/, $contents);
   
   foreach my $w (@words) {
      my $s = getWordScore($w);
      my $t = $s * 2;
      my $u = int(sqrt($t));
      if ($u * ($u + 1) == $t) {
         $total += 1;
      }
   }
   
   print "$total\n";
   
}



sub getWordScore {
   my $w = shift || '';
   
   my $retval = 0;
   foreach my $c (split(//, $w)) {
      if (! defined $score{$c}) {
         print $c."\n";
      }
      $retval += $score{$c};
   }
   
   return $retval;
}





