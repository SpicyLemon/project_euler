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
   my $maxx = 0;

   my @Ds = (
       97, 109, 139, 149, 151, 157, 163, 166, 
      181, 193, 199, 211, 214, 233, 241, 244, 
      253, 261, 262, 265, 268, 271, 277, 281, 283, 
      298, 301, 307, 309, 313, 317, 331, 
      334, 337, 343, 349, 353, 358, 367, 373, 
      379, 382, 388, 393, 394, 397, 406, 409, 412, 415, 
      417, 419, 421, 424, 431, 433, 436, 445, 446, 449, 
      451, 454, 457, 461, 463, 466, 477, 478, 481, 487, 
      489, 491, 493, 501, 502, 508, 509, 511, 513, 517, 
      519, 521, 523, 524, 526, 533, 537, 538, 541, 547, 
      549, 550, 553, 554, 556, 559, 562, 565, 566, 569, 
      571, 581, 586, 589, 593, 596, 597, 599, 601, 604, 
      606, 607, 610, 613, 614, 617, 619, 622, 628, 629, 
      631, 633, 634, 637, 639, 641, 643, 647, 649, 652, 
      653, 655, 661, 662, 664, 666, 667, 669, 673, 679, 
      681, 683, 685, 686, 688, 691, 694, 698, 701, 709, 
      716, 718, 719, 721, 722, 724, 733, 734, 737, 739, 
      742, 745, 746, 749, 751, 753, 754, 757, 758, 763, 
      764, 766, 769, 771, 772, 773, 778, 779, 781, 787, 
      789, 790, 794, 796, 797, 801, 802, 805, 807, 808, 
      809, 811, 814, 821, 823, 826, 829, 834, 835, 838, 
      844, 845, 849, 853, 856, 857, 859, 861, 862, 863, 
      865, 869, 871, 873, 877, 879, 881, 883, 886, 889, 
      893, 907, 911, 913, 914, 917, 919, 921, 922, 926, 
      928, 929, 931, 932, 937, 941, 946, 947, 949, 951, 
      953, 954, 955, 956, 958, 964, 965, 967, 969, 970, 
      971, 972, 974, 976, 977, 981, 988, 989, 991, 997, 
      998, 999, 1000
   );
   my $xrange_min = 10000000;
   my $xrange_max = 20000000;
   
   while ($#Ds >= 0) {
      my @x2m1 = ();
      foreach my $x ($xrange_min..$xrange_max) {
         my $x2 = $x * $x - 1;
         push (@x2m1, $x2);
      }
      my @redo = ();

      foreach my $D (@Ds) {
         print "$D: "; $|=1;
         my $sqd = sqrt($D);
         if ($sqd == int($sqd)) {
            print "perfect square skipped\n";
            next;
         }
         my $found = 0;
         foreach my $i (2..$#x2m1) {
            my $q = $x2m1[$i];
            if ($q % $D == 0) {
               #now, make sure $q/$D is a perfect square
               my $y = sqrt($q/$D);
               if ($y == int($y)) {
                  $found = 1;
                  my $x = $i + $xrange_min;
                  print "x = $x, y = $y\t$x ^ 2 - $D * $y ^ 2 = 1";
                  if ($x > $maxx) {
                     $maxx = $x;
                     $answer = $D;
                  }
                  last;
               }
            }
         }
         if (!$found) {
            print "!!!!! x > $xrange_max !!!!!";
            push (@redo, $D);
         }
         print "\n";
      }
      if (@redo) {
         print "These need to be redone with a higher max range than $xrange_max.\n";
         print join(", ", @redo)."\n";
      }
      @Ds = @redo;
      $xrange_min = $xrange_max;
      $xrange_max += 10000000;
   }

   print "Answer: $answer\n";

}



