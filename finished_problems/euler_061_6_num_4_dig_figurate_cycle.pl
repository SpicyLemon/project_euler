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


my @loops = ();



mainProgram();
my $_time_stop =  time;
my $_elapsed_time = $_time_stop - $_time_start;
print "Elapsed time (seconds): $_elapsed_time\n";
exit(0); 



sub mainProgram {

   my $answer = 0;
   
   my @limits = (
      {
         name => '3',
         s => \&triangle,
         min => 45,
         max => 140,
      },
      {
         name => '4',
         s => \&square,
         min => 32,
         max => 99,
      },
      {
         name => '5',
         s => \&pentagonal,
         min => 26,
         max => 81,
      },
      {
         name => '6',
         s => \&hexagonal,
         min => 23,
         max => 70,
      },
      {
         name => '7',
         s => \&heptagonal,
         min => 21,
         max => 63,
      },
      {
         name => '8',
         s => \&octagonal,
         min => 19,
         max => 58,
      },      
   );
   
   my %pf = ();
   
   foreach my $s (@limits) {
      foreach my $n ($s->{min}..$s->{max}) {
         my $q = $s->{s}($n);
         my $f = substr($q, 0, 2);
         my $b = substr($q, -2);
         push (@{$pf{f}->{$f}}, { v => $b, s => $s->{name} });
      }
   }
   
   #pf now looks kind of like this:
   #%pf = (
   #   f => {
   #      12 => [ { v => 34, s => 3 }, { v => 45, s => 4 }, ],
   #      56 => [ { v => 78, s => 3 }, { v => 89, s => 3 }, ],
   #   }
   #}
   
   #remove any that simply won't work.
   foreach my $f (keys %{$pf{f}}) {
      my @newf = ();
      foreach my $s (@{$pf{f}->{$f}}) {
         if ($s->{v} != $f && exists $pf{f}->{$s->{v}}) {
            #add it in the b part of the hash, just in case we want it later
            push (@{$pf{b}->{$s->{v}}}, { v => $f, s => $s->{name} });
            #add it to the list of f's to keep
            push (@newf, $s);
         }
         else {
            #get rid of it!
            #um... nothing really to do here
         }
      }
      $pf{f}->{$f} = \@newf;
   }
            
   
   #rearange things a bit
   my %p = ();
   foreach my $f (keys %{$pf{f}}) {
      foreach my $s (@{$pf{f}->{$f}}) {
         if (! exists $p{$s->{s}}->{f}) {
            $p{$s->{s}}->{f} = {};
         }
         if (! exists $p{$s->{s}}->{f}->{$f}) {
            $p{$s->{s}}->{f}->{$f} = [];
         }
         if (! exists $p{$s->{s}}->{b}) {
            $p{$s->{s}}->{b} = {};
         }
         if (! exists $p{$s->{s}}->{b}->{$s->{v}}) {
            $p{$s->{s}}->{b}->{$s->{v}} = [];
         }
         push (@{$p{$s->{s}}->{f}->{$f}}, $s->{v});
         push (@{$p{$s->{s}}->{b}->{$s->{v}}}, $f);
      }
   }
   
   #Okay, $p is created.  It looks something like this
   #%p = (
   #   3 => {
   #      f => { 12 => [ 34, 45 ], 56 => [ 78, 79 ], }
   #      b => { 34 => [ 12 ], 34 => [ 12 ], 78 => [ 56 ], 79 => [ 56 ], }
   #   },
   #   4 => {
   #      f => { 12 => [ 34, 45 ], 56 => [ 78, 79 ], }
   #      b => { 34 => [ 12 ], 34 => [ 12 ], 78 => [ 56 ], 79 => [ 56 ], }
   #   },
   #);
   
   
   #and last structer that might be handy, basically, a 2 dimentional array
   #key is first two digits, value is a 6 value array for P 3, 4, 5, 6, 7, 8.
   my %pa = ();
   foreach my $f (sort keys %{$pf{f}}) {
      my @newpa = ();
      foreach my $t (3..8) {
         my $o = '';
         foreach my $s (@{$pf{f}->{$f}}) {
            if ($s->{s} == $t) {
               $o = $s->{v};
            }
         }
         push (@newpa, $o);
      }
      $pa{$f} = \@newpa;
   }
   
   
   #print that array just to see what we've got.
   foreach my $f (sort keys %pa) {
      #print "$f: ".join('  ', @{$pa{$f}})."\n";
   }
   
   
   #I think here, I'll want to set up a tree.
   #I'm not too sure how I'll want to do that.
   #Basic thought:
   # Create a hash (called %tree maybe?)
   # The main keys will be 10-99
   # each of those values will be an array of 6 hashes
   # Each of those hashes will have the key of a possible next value
   # ... and so on, down to 6.
   # There should only be a few that have the 6th, the winner is the one
   # with a final value, that is the same as the main, head key value.
   foreach my $k (sort keys %pa) {
      cycle('', [$k], \%pa);
   }
   my @results = ();
   foreach my $l (@loops) {
      if ($l->[0] == $l->[-1]) {
         @results = @$l;
      }
   }
   foreach my $i (0..5) {
      $answer += $results[$i].$results[$i+1];
   }
   
   
   print "Answer: $answer\n";
}

sub triangle {
   return $_[0] * ($_[0] + 1) / 2;
}

sub square { 
   return $_[0] * $_[0];
}

sub pentagonal {
   return $_[0] * (3 * $_[0] - 1) / 2;
}

sub hexagonal {
   return $_[0] * (2 * $_[0] - 1);
}

sub heptagonal {
   return $_[0] * (5 * $_[0] - 3) / 2;
}

sub octagonal {
   return $_[0] * (3 * $_[0] - 2);
}

sub cycle {
   my $used = shift;
   my $chain = shift;
   my $pa = shift;
   my @dive = ();
   my $front = $chain->[-1];
   foreach my $i (0..5) {
      if ($pa->{$front}->[$i] && $used !~ /$i/) {
         push (@dive, { s => $i, v => $pa->{$front}->[$i] });
      }
   }
   if (length($used) == 5 && $#dive == 0) {
      push (@loops, [ @$chain, $dive[0]->{v} ]);
   }
   else {
      foreach my $d (@dive) {
         cycle($used.$d->{s}, [ @$chain, $d->{v} ], $pa);
      }
   }
   return 1;
}
