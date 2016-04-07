#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;  $Data::Dumper::Sortkeys = 1;

use lib qw(.);
use myMath;


mainProgram();
exit(0);


sub mainProgram {
   my @list = (0..4);
   my $groups = myMath::getGroups(\@list, 5);
   foreach my $group (@$groups) {
      print join(", ", @$group)."\n";
   }
}