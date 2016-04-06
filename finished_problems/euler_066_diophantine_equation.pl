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

my $max = 10;

if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $max = $1;
}
my $arg2 = 10;
if ($ARGV[1] && $ARGV[1] =~ /^(\d+)$/) {
   $arg2 = $1;
}



#testProgram();
mainProgram();
my $_time_stop =  time;
my $_elapsed_time = $_time_stop - $_time_start;
print "Elapsed time (seconds): $_elapsed_time\n";
exit(0); 


sub testProgram {
   print 'Min x for x**2 - '.$max.'*y**2 = 1: '.getMinX($max)."\n";
}

sub mainProgram {

   my $answer = 0;
   my $max_x = 0;
   
   for (my $i = 1; $i <= $max; $i++) {
      my $x = getMinX($i);
      if ($x > $max_x) {
         $answer = $i;
         $max_x = $x;
      }
   }
   
   print "Answer: $answer\n";
}


sub getCFForSqrt {
   my $v = shift;
   my $debug = shift;
   my $sqrtv = sqrt($v);
   my %retval = ( a0 => int($sqrtv), ai => [], v => $v, sqrtv => $sqrtv );
   if (!myMath::isZeroish($sqrtv - $retval{a0})) {
      my @p = (
         { a => int($sqrtv), b => int($sqrtv), c => 1 },
      );
      my $loop_found = 0;
      if ($debug) {
         print join("\t", ('v', 'i', 'a', 'b', 'c', 'loop', 'sqrtv'))."\n";
         print join("\t", ($v, $#p, $p[0]->{a},$p[0]->{b},$p[0]->{c}, $loop_found, $sqrtv))."\n";
      }
      while (!$loop_found) {
         my %i = ( a => 0, b => 0, c => 0 );
         my %i1 = %{$p[-1]};
         $i{a} = int($i1{c}/($sqrtv - $i1{b}));
         $i{b} = $i{a} * ($v - $i1{b} ** 2) / $i1{c} - $i1{b};
         $i{c} = ($v - $i1{b} ** 2)/$i1{c};
         push (@p, \%i);
         push (@{$retval{ai}}, $i{a});
         if ($i{c} == 1) {
            $loop_found = 1;
         }
         if ($debug) {
            print join("\t", ($v, $#p, $p[-1]->{a},$p[-1]->{b},$p[-1]->{c}, $loop_found, $sqrtv));
            my $tosser = <STDIN>;
         }
      }
   }
   return \%retval;
}

sub printCf {
   my $v = shift;
   my $debug = shift;
   my $cf = (!ref $v) ? getCFForSqrt($v, $debug) : $v;
   my $output = $cf->{v}.' = ['.$cf->{a0}.'; ('.join(', ', @{$cf->{ai}}).')]';
   print $output."\n";
   return $output;
}


sub getFraction {
   my $cf = shift;
   my $n = shift;
   my $cflist = getCFList($cf, $n);
   my $num = Math::BigInt->bone();
   my $dem = Math::BigInt->new(pop(@$cflist));
   while (scalar @$cflist > 0) {
      $num->badd($dem->copy()->bmul(pop(@$cflist)));
      ($num, $dem) = ($dem, $num);
   }
   return ($dem, $num);
}


sub getCFList {
   my $cf = shift;
   my $n = shift;
   my @retval = ();
   if ($n >= 0) {
      push (@retval, $cf->{a0});
      my $curi = 0;
      my $maxi = $#{$cf->{ai}};
      while ($#retval < $n) {
         push (@retval, $cf->{ai}->[$curi]);
         $curi += 1;
         if ($curi > $maxi) {
            $curi = 0;
         }
      }
   }
   return \@retval;
}


sub getMinX {
   my $d = shift;
   my $debug = shift;
   my $cfd = getCFForSqrt($d, $debug);
   
   my $i = 0;
   my $retval = undef;
   if (scalar @{$cfd->{ai}} == 0) {
      $retval = 0;
   }
   while (! defined $retval) {
      my ($x, $y) = getFraction($cfd, $i);
      $retval = $x->bstr();
      if ($x->bpow(2)->bsub($y->bpow(2)->bmul($d)) != 1) {
         $retval = undef;
      }
      $i += 1;
   }
   return $retval;
}


