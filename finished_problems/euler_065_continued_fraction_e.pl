#!/usr/bin/perl
use strict;
use warnings;
use Math::BigInt;
#use Math::BigFloat;
use Data::Dumper;
use lib qw(.);
use myMath;
#use Prompt;
my $_time_start = time;

Math::BigInt->accuracy(100);

my $max = 10;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}



testProgram();
mainProgram();
my $_time_stop =  time;
my $_elapsed_time = $_time_stop - $_time_start;
print "Elapsed time (seconds): $_elapsed_time\n";
exit(0); 

sub testProgram {
   my @l = ();
   for my $n (2..20) {
      push(@l, cfe($n));
   }
   print 'e = ['.cfe(1).'; '.join(',', @l).", ...]\n";
}

sub mainProgram {

   my $answer = 0;
   
   my $cur_num = Math::BigInt->bone();
   my $cur_den = Math::BigInt->new(cfe($max));
   
   for (my $i = $max - 1; $i >= 0; $i--) {
      ($cur_num, $cur_den) = ($cur_den, $cur_num->badd($cur_den->copy()->bmul(cfe($i))));
   }
   print $max.': '.$cur_num.'/'.$cur_den."\n";
   foreach my $d (split(//, $cur_num)) {
      $answer += $d;
   }
   
   print "Answer: $answer\n";
}


sub cfe {
   return $_[0] < 0 ? 0
        : $_[0] == 1 ? 2
        : $_[0] % 3 == 0 ? 2*int(($_[0])/3) 
        : 1;
}






