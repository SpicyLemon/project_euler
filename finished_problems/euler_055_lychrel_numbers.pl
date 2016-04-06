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




mainProgram();
my $_time_stop =  time;
my $_elapsed_time = $_time_stop - $_time_start;
print "Elapsed time (seconds): $_elapsed_time\n";
exit(0); 



sub mainProgram {

   my $answer = 0;
   
   foreach my $i (1..$max) {
      my $v = Math::BigInt->new($i);
      my $rv = scalar reverse $v;
      foreach my $j (1..50) {
         $v = $v->badd($rv);
         $rv = scalar reverse $v;
         if ($v eq $rv) {
            last;
         }
      }
      if ($v ne $rv) {
         $answer += 1;
         print "$i = $v after 50 iterations.\n";
      }
   }
   
   print "Answer: $answer\n";

}


sub reverseString {
   return scalar reverse $_[0];
}


sub isPalindrome {
   my $v = shift;
   return ($v eq join('', reverse split(//, $v))) ? 1 : 0;
}






