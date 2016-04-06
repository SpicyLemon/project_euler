#!/usr/bin/perl -w

#this gets the lines asked for by number
#usage
#  getlines.pl <filename> [<line#1>-<line#2> | <line#1> ] ...

use strict;

#get all the input needed
my $fn = "";   #filename
my @ln = ();   #line numbers
if ($#ARGV < 0)  {
   die "Usage: getlines.pl <filename> [<line#1>-<line#2> | <line#1> ] ...\n";
} else {
   $fn = $ARGV[0];
   foreach my $i (1..$#ARGV) {
      if ($ARGV[$i] =~ /^(\d+)$/) {
         push (@ln, $1);
      } elsif ($ARGV[$i] =~ /^(\d+)-(\d+)$/) {
         push (@ln, $1 .. $2);
      } else {
         die "Usage: getlines.pl <filename> [<line#1>-<line#2> | <line#1> ] ...\n";
      }
   }
}

#put the line numbers in order
@ln = sort {$a <=> $b} @ln;

my $just_count = 0;
if ($#ln < 0) {
   $just_count = 1;
}

#go through the file and get the requested lines
my @lines;

open (INFILE, $fn) or die "Could not open ".$fn." for reading.\nERROR:$!\n";

my $c = 0;
my $lenc = 0;
while ( defined(my $l = <INFILE>) && (($#ln >= 0) || $just_count) ) {
   $c += 1;
   if (!$just_count && $c == $ln[0]) {
      push (@lines, { N => $c, L => $l} );
      $lenc = length($c) if (length($c) > $lenc);
      shift @ln;
   }
}

if ($just_count) {
   print "file contains $c lines.\n";
}
else {
   foreach my $l (@lines) {
      print substr((" " x $lenc).$l->{N}, -($lenc)).": ".$l->{L};
   }
}
