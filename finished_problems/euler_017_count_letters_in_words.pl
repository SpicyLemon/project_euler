#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;

#one two three four five six seven eight nine ten 
#eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty
#thirty forty fifty sixty seventy eighty ninety 
#hundred thousand

#1-9 are used 9 times / hundred
#10-19 are used 1 time/ hundred
#30,40, etc are used 10 times per hundred
#there are 10,000 hundreds in a million

#each hundred is used 10 times in a thousand

my %word = (  
   1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four', 5 => 'five',
   6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine', 10 => 'ten',
   11 => 'eleven', 12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen', 15 => 'fifteen',
   16 => 'sixteen', 17 => 'seventeen', 18 => 'eighteen', 19 => 'nineteen', 20 => 'twenty',
   30 => 'thirty', 40 => 'forty', 50 => 'fifty', 60 => 'sixty', 70 => 'seventy', 80 => 'eighty', 90 => 'ninety',
);


mainProgram();
exit(0); 



sub mainProgram {

   my $tot = 0;
   foreach my $i (1..999) {
      my $s = convertToWord($i);
      $s =~ s/\W//g;
      $tot += length($s);
   }
   $tot += length('onethousand');

   print $tot."\n";

}



#min   0
#max 999
sub convertToWord {
   my $number = shift || 0;
   $number = substr(('0' x 3).$number, -3);

   my $hundred = substr($number, 0, 1) * 1;
   my $tens = substr($number, 1, 2) * 1;

   my $retval = '';


   if ($hundred > 0) {
      $retval = $word{$hundred}.' hundred';
   }
   if ($tens > 0) {
      if ($retval) {
         $retval .= ' and ';
      }
      if (exists $word{$tens}) {
         $retval .= $word{$tens};
      }
      else {
         my $ten = int($tens / 10) * 10;
         my $one = $tens % 10;
         $retval .= ($ten > 0 && $one > 0) ? $word{$ten}.'-'.$word{$one}
                  : ($one > 0)             ? $word{$one}
                  :                          ''
                 ;
      }
   }

   if (!$retval) {
      $retval = 'zero';
   }

   return $retval;

}
