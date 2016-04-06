#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;





mainProgram();
exit(0); 



sub mainProgram {

   my $pd = '123456789';
   
   my $total = 0;
   
   my $INFILE = undef;
   open ($INFILE, $myMath::prime_file) or die "Could not open $myMath::prime_file for reading.\n$!\n";
   while (my $line = <$INFILE>) {
      chomp $line;
      if (join('', sort split(//, $line)) eq substr($pd, 0, length($line))) {
         $total = $line;
         print "$total\n";
      }
   }
   close ($INFILE);
   
   
   print "$total\n";


}






