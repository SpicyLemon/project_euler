#!/usr/bin/perl -w
use strict;
#use lib qw(.);
#use printers;  #qw(listOfHashRefs csv hash indent);
use easyopen qw(openr openread openw openwrite opena openappend slurpFile);
#use fake_list_data; #qw(d l L c w date firstname lastname fullname business address city state zip zip4 location amount purpose word rib ri r Time dateAndTime);
#use logger; #qw(printlog dielog dieMessage logfile printlogWithBorder dielogWithBorder addBorderTo);
#use DateTime;
#use Date::Parse; #imports str2time that takes in a string, and outputs an epoch.
use Time::HiRes qw(time usleep);  #this forces the time() function to return nanosecond information
#use Benchmark ':hireswallclock';
#use Fcntl;
#use SDBM_File;
use Data::Dumper;  $Data::Dumper::Sortkeys = 1;
#use List::Util 'shuffle';
#use Prompt; #imports the prompt function


use myMath;


my $v = 1;
if ($ARGV[0] && $ARGV[0] =~ /^(\d+)$/) {
   $v = $1;
}

my $maxp = int(sqrt($v));
my $parp = int(sqrt($maxp));

my $non_start = time;
my $non_factors = myMath::factor($v);
my $non_stop = time;

myMath::initializePrimeList($parp);

my $par_start = time;
my $par_factors = myMath::factor($v);
my $par_stop = time;

myMath::initializePrimeList($maxp);

my $ini_start = time;
my $ini_factors = myMath::factor($v);
my $ini_stop = time;

my $non_dur = $non_stop - $non_start;
my $par_dur = $par_stop - $par_start;
my $ini_dur = $ini_stop - $ini_start;

print "timings for factoring $v - (sqrt = $maxp)\n";
print "    uninitialized prime list: ".formatdur($non_dur)." ($non_dur seconds)\n";
print "partially initilialized list: ".formatdur($par_dur)." ($par_dur seconds)\n";
print "      initialized prime list: ".formatdur($ini_dur)." ($ini_dur seconds) \n";

#make sure all the lists are the same
my $not_right = 0;
if ($#$non_factors != $#$par_factors || $#$par_factors != $#$ini_factors) {
   $not_right = 1;
}
else {
   foreach my $i (0..$#$non_factors) {
      if ($non_factors->[$i] != $par_factors->[$i] 
      || $par_factors->[$i] != $ini_factors->[$i]
      ) {
         $not_right = 1;
      }
   }
}

if ($not_right) {
   print "One of the calculations is incorrect:\n";
   print "    uninitialized prime list: ".join(',', @$non_factors)."\n";
   print "partially initilialized list: ".join(',', @$par_factors)."\n";
   print "      initialized prime list: ".join(',', @$ini_factors)."\n";
}
else {
   print "$v = ".join(' * ', @$ini_factors)."\n";
}

#print Dumper($non_factors, $par_factors, $ini_factors)."\n";
exit(0);



sub formatdur {
   my $dur = shift || 0;
   if ($dur =~ /^(\d)\.(\d+)e-(\d\d\d)$/) {
      my $v1 = $1;
      my $v2 = $2;
      my $e = $3;
      $dur = '.'.('0' x ($e - 1)).$v1.$v2;
   }
   my $m = int($dur / 60);
   my $s = int($dur) % 60;
   my $n = $dur.'';  #to make it a string
   $n =~ s/^\d*\.//;
   my $retval = substr('0'.$m, -2).':'.substr('0'.$s, -2).'.'.substr($n.(' ' x 9), 0, 9);
   return $retval;
}
