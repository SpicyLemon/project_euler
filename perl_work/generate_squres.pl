#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;
my $_time_start = time;

my $max = 10;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}

my $fn = 'squares.txt';



mainProgram();
my $_time_stop =  time;
my $_elapsed_time = $_time_stop - $_time_start;
print "Elapsed time (seconds): $_elapsed_time\n";
exit(0); 



sub mainProgram {

   
   my $i = 0;
   
   if (-e $fn) {
      my $INFILE = undef;
      open ($INFILE, $fn) or die "Could not open $fn for reading.\n$!\n";
      while(<$INFILE>) {
         if (/\d/) {
            $i += 1;
         }
      }
      close ($INFILE);
      print "$fn contains the first $i squares.\n";
   }
   
   if ($i >= $max) {
      die "$max <= $i. No more squares need to be calculated\n";
   }
   
   #i is where we'll start
   $i += 1;
   
   print "Adding squares from $i to $max to $fn\n";
   
   my $use_bigint = 0;
   
   my $OUTFILE = undef;
   open ($OUTFILE, '>>'.$fn) or die "Could not open $fn for writing\n$!\n";
   while ($i <= $max) {
      my $s = undef;
      if ($use_bigint) {
         $s = Math::BigInt->new($i)->bmul($i)->bstr();
      }
      else {
         $s = $i * $i;
         if ($s =~ /\D/) {
            $use_bigint = 1;
            $s = Math::BigInt->new($i)->bmul($i)->bstr();
         }
      }
      if ($i % 10000 == 0) {
         print "$i: $s\n";
      }
      print $OUTFILE "$s\n";
      $i += 1;
   }
   close ($OUTFILE);
   print "Done\n";
   if ($use_bigint) {
      print "We're bigint terretory.\n";
   }
}






