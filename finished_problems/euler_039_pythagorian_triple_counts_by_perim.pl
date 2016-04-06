#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;


my $max = 1000;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}



mainProgram();
exit(0); 



sub mainProgram {

   my %count = ();
   
   foreach my $aa (1..int($max/3)) {
      foreach my $bb ($aa..int($max/2)) {
         my $cc = sqrt($aa * $aa + $bb * $bb);
         if ($cc == int($cc)) {
            my $p = $aa + $bb + $cc;
            push (@{$count{$p}}, { a => $aa, b => $bb, c => $cc });
         }
      }
   }
   
   my $maxc = 0;
   my $max = 0;
   
   foreach my $k (keys %count) {
      my $c = scalar @{$count{$k}};
      if ($c > $maxc) {
         $maxc = $c;
         $max = $k;
      }
   }
   
   print "$max: $maxc\n";
   my @o = ();
   foreach my $t (@{$count{$max}}) {
      push (@o, '('.$t->{a}.', '.$t->{b}.', '.$t->{c}.')');
   }
   print join(' ', @o)."\n";


}






