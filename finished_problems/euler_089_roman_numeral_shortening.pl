#!/usr/bin/perl
use strict;
use warnings;
use Math::BigInt;
use Data::Dumper;
use lib qw(.);
use myMath;
use Prompt;
my $_time_start = time;

my $debug = 0;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $debug = $1;
}


my %romanNumeralValue = (
   I  =>    1,
   IV =>    4,
   V  =>    5,
   IX =>    9,
   X  =>   10,
   XL =>   40,
   L  =>   50,
   XC =>   90,
   C  =>  100,
   CD =>  400,
   D  =>  500,
   CM =>  900,
   M  => 1000,
);
my %romanNumeralString = map { $romanNumeralValue{$_} => $_ } keys %romanNumeralValue;
my @romanNumeralValuesDesc = sort { $b <=> $a } keys %romanNumeralString;
my @romanNumeralStringsDesc = sort { $romanNumeralValue{$b} <=> $romanNumeralValue{$a} } keys %romanNumeralValue;

print 'romanNumeralValuesDesc: '.join(', ', @romanNumeralValuesDesc)."\n";


if ($debug) {
   testProgram();
}
else {
   mainProgram();
}
my $_time_stop =  time;
my $_elapsed_time = $_time_stop - $_time_start;
print "Elapsed time (seconds): $_elapsed_time\n";
exit(0); 


sub testProgram {
   do {
      my $rn = prompt("Roman numeral to convert");
      print "'$rn' = ".RomanToArabic(uc($rn))."\n";
      my $ar = prompt("number to convert to Roman Numeral");
      print "$ar = '".ArabicToRoman($ar)."'\n";
   } while (Prompt::promptYesNo('Another round', 1));
   if (Prompt::promptYesNo('Continue on to mainProgram', 0)) {
      mainProgram();
   }
}

sub mainProgram {

   my $answer = 0;
   
   my $fn = 'p089_roman.txt';
   open (my $INFILE, $fn) or die "Could not open $fn for reading: $!\n";
   while (my $line = <$INFILE>) {
      $line =~ s/\s+$//;
      my $better = ArabicToRoman(RomanToArabic($line));
      $answer += length($line) - length($better);
   }
   
   print "Answer: $answer\n";
}


sub RomanToArabic {
   my $roman = shift;
   my $retval = 0;
   
   while (length($roman) > 0) {
      Prompt::debugPrintWait($debug, "roman = $roman, retval = $retval");
      my $found = 0;
      foreach my $num (@romanNumeralStringsDesc) {
         if ($num eq substr($roman, 0, length($num))) {
            $retval += $romanNumeralValue{$num};
            substr($roman, 0, length($num), '');
            $found = 1;
            last;
         }
      }
      if (! $found) {
         print "Problem with $roman\n";
         $roman = '';
         $retval = 0;
      }
   }
   
   return $retval;
}

sub ArabicToRoman {
   my $arabic = shift;
   my $retval = '';
   
   while ($arabic > 0) {
      Prompt::debugPrintWait($debug, "arabic = $arabic, retval = $retval");
      my $found = 0;
      foreach my $val (@romanNumeralValuesDesc) {
         if ($arabic >= $val) {
            $retval .= $romanNumeralString{$val};
            $arabic = $arabic - $val;
            $found = 1;
            last;
         }
      }
      if (! $found) {
         print "Problem with $arabic\n";
         $arabic = 0;
         $retval = '';
      }
   }
   
   return $retval;
}






