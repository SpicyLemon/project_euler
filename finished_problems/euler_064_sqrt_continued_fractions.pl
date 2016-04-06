#!/usr/bin/perl
use strict;
use warnings;
use Math::BigInt;
use Math::BigFloat;
use Data::Dumper;
use lib qw(.);
use myMath;
my $_time_start = time;

myMath::setZeroishThreshold(.00001);
#Math::BigFloat->precision(-500);

my $longest_val = 0;
my $longest_val_a0 = 0;
my @longest = ();

my $max = 13;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}



#testProgram();
mainProgram();
my $_time_stop =  time;
my $_elapsed_time = $_time_stop - $_time_start;
print "Elapsed time (seconds): $_elapsed_time\n";
exit(0); 

sub testProgram {
   countRep($max, 1);
}


sub mainProgram {

   my $answer = 0;
   
   for(my $i = 2; $i <= $max; $i++) {
      if (countRep($i) % 2 == 1) {
         $answer++;
      }
   }
   
   print 'longest: '.$longest_val.' = ['.$longest_val_a0.';('.join(',', @longest).')]'."\n";
   print "Answer: $answer\n";
}


sub countRep {
   my $v = shift;
   my $debug = shift;
   my $retval = 0;
   my $sqrtv = sqrt($v);
   my $a0 = int($sqrtv);
   my $r0 = $sqrtv - $a0;
   my ($an, $rn) = ($a0, $r0);
   if (myMath::isZeroish($rn)) {
      print "$v. = square\n";
   }
   else {
      my @iter = ();
      my $rep_found = 0;
      my $overflow = 0;
      if ($debug) {
         print join("\t", ('a0', 'r0', 'n', 'an', 'rn', 'rep_found'))."\n";
      }
      while (!$rep_found && !$overflow) {
         ($an, $rn) = nextIteration($rn);
         push (@iter, $an);
         if (scalar @iter > 0 && myMath::areSameish($r0, $rn)) {
            $rep_found = 1;
         }
         if ($debug) {
            print join("\t", ($a0, $r0, scalar @iter, $an, $rn, $rep_found));
            my $tosser = <STDIN>;
         }
         if (scalar @iter >= 10) {
            $overflow = 1;
         }
      }
      if ($rep_found) {
         print $v.' = ['.$a0.';('.join(',', @iter).')]'."\n";
         $retval = scalar @iter;
      }
      elsif ($overflow) {
         if ($debug) {
            print "Switching over to big float.\n";
         }
         $retval = countRepBigFloat($v, $debug);
      }
      else {
         die "what?";
      }
   }
   return $retval;
}


sub nextIteration {
   my $rn = shift;
   my $v = 1/$rn;
   my $reta = int($v);
   my $retr = $v - $reta;
   return ($reta, $retr);
}


sub countRepBigFloat {
   my $v = shift;
   my $debug = shift;
   my $precision = shift || 40;
   my $overflow_count = int($precision * .8);
   my $retval = 0;
   my $sqrtv = Math::BigFloat->new($v);
   $sqrtv->precision(-1 * $precision);
   $sqrtv->bsqrt();
   my $a0 = int($sqrtv);
   my $r0 = $sqrtv->copy()->bsub($a0);
   my ($an, $rn) = ($a0, $r0->copy());
   if (myMath::isZeroish($rn)) {
      print "$v is square\n";
   }
   else {
      my @iter = ();
      my $rep_found = 0;
      my $overflow = 0;
      if ($debug) {
         print "precision: $precision\n";
         print "overflow count: $overflow_count\n";
         print join("\t", ('a0', 'r0', 'n', 'an', 'rn', 'rep_found'))."\n";
      }
      while (!$rep_found && !$overflow) {
         $rn->bpow(-1);
         $an = $rn->copy()->bint();
         $rn->bsub($an);
         push (@iter, $an->ffround(0));
         if (scalar @iter > 0 && myMath::areSameish($r0, $rn)) {
            $rep_found = 1;
         }
         if ($debug) {
            print join("\t", ($a0, $r0, scalar @iter, $an, $rn, $rep_found));
            my $tosser = <STDIN>;
         }
         if (scalar @iter >= $overflow_count) {
            $overflow = 1;
         }
      }
      if ($rep_found) {
         print $v.' = *['.$a0.';('.join(',', @iter).')]'."\n";
         $retval = scalar @iter;
         if (scalar @longest < $retval) {
            $longest_val = $v;
            $longest_val_a0 = $a0;
            @longest = @iter;
         }
      }
      elsif ($overflow) {
         my $new_precision = $precision * 2;
         if ($debug) {
            print "Increasing precision to ".$new_precision."\n";
         }
         $retval = countRepBigFloat($v, $debug, $new_precision);
      }
      else {
         die "what?";
      }
   }
   return $retval;
}







