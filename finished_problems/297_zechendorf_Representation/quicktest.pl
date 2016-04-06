#!/usr/bin/perl -w
use strict;
#use lib qw(.);
#use printers;  #qw(listOfHashRefs csv hash indent);
use easyopen qw(openr openread openw openwrite opena openappend slurpFile);
#use fake_list_data; #qw(d l L c w date firstname lastname fullname business address city state zip zip4 location amount purpose word rib ri r Time dateAndTime);
#use logger; #qw(printlog dielog dieMessage logfile printlogWithBorder dielogWithBorder addBorderTo);
#use DateTime;
#use Date::Parse; #imports str2time that takes in a string, and outputs an epoch.
#use Time::HiRes qw(time usleep);  #this forces the time() function to return nanosecond information
#use Benchmark ':hireswallclock';
#use Fcntl;
#use SDBM_File;
use Data::Dumper;  $Data::Dumper::Sortkeys = 1;
#use List::Util 'shuffle';
#use Prompt; #imports the prompt function
use HTML::Entities;


my $target = 10;
if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $target = $1;
}

my @fibs = (1, 2);
while ($fibs[-1] < $target) {
   push (@fibs, $fibs[-1] + $fibs[-2]);
}
print join("\n", @fibs)."\n";

@fibs = reverse(@fibs);

my @znums = zout($target);
print $target.' = '.join(' + ', @znums)."\n";


sub zout {
   my $n = shift;
   my @retval = ();
   
   foreach my $f (@fibs) {
      if ($f <= $n) {
         push(@retval, $f);
         $n = $n - $f;
      }
   }
   
   return @retval;
}
