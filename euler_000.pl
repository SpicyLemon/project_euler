#!/usr/bin/perl
use strict;
use warnings;
#use Math::BigInt;
#use Math::BigFloat;
use Data::Dumper;
use lib qw(.);
use myMath;
#use Prompt;
my $_time_start = time;

my $max = 10;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}



testProgram();
#mainProgram();
my $_time_stop =  time;
my $_elapsed_time = $_time_stop - $_time_start;
print "Elapsed time (seconds): $_elapsed_time\n";
exit(0); 


sub testProgram {
}

sub mainProgram {

   my $answer = 0;
   
   
   
   print "Answer: $answer\n";


}






