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

#this one done by hand:
# min = ceiling((10**(n-1))**(1/n))
# max = floor((10**(n)-1)**(1/n))
# done when the number of digits in 9^n is less than n.
# 1: 1, 2, 3, 4, 5, 6, 7, 8, 9
# 2: 4, 5, 6, 7, 8, 9
# 3: 5, 6, 7, 8, 9
# 4: 6, 7, 8, 9
# 5: 7, 8, 9
# 6: 7, 8, 9
# 7: 8, 9
# 8: 8, 9
# 9: 8, 9
#10: 8, 9
#11: 9
#12: 9
#13: 9
#14: 9
#15: 9
#16: 9
#17: 9
#18: 9
#19: 9
#20: 9
#21: 9
#22: none

sub mainProgram {

   my $answer = 0;

   my @answers = (
      [],
      [1, 2, 3, 4, 5, 6, 7, 8, 9],
      [4, 5, 6, 7, 8, 9],
      [5, 6, 7, 8, 9],
      [6, 7, 8, 9],
      [7, 8, 9],
      [7, 8, 9],
      [8, 9],
      [8, 9],
      [8, 9],
      [8, 9],
      [9],
      [9],
      [9],
      [9],
      [9],
      [9],
      [9],
      [9],
      [9],
      [9],
      [9],
      [],
   );
   
   print "This one done by hand.\n"
        ."min = ceiling((10**(n-1))**(1/n))\n"
        ."max = floor((10**(n)-1)**(1/n))\n"
        ."done when the number of digits in 9^n is less than n.\n"
        ."\n"
       ;
   for(my $i = 1; $i <= $#answers; $i++) {
      $answer += scalar @{$answers[$i]};
      print substr('   '.$answer, -3).' <- '.substr(' '.$i, -2).': '.join(', ', @{$answers[$i]})."\n";
   }
   print "\n";
   print "Answer: $answer\n";


}






