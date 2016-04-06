#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use Math::BigInt;
use Data::Dumper;

my $input_file = 'names.txt';
my $sorted_file = 'names_sorted.txt';

my %value = ( 
   'A'=> 1, 'B'=> 2, 'C'=> 3, 'D'=> 4, 'E'=> 5, 'F'=> 6, 'G'=> 7, 'H'=> 8, 'I'=> 9, 
   'J'=>10, 'K'=>11, 'L'=>12, 'M'=>13, 'N'=>14, 'O'=>15, 'P'=>16, 'Q'=>17, 'R'=>18, 
   'S'=>19, 'T'=>20, 'U'=>21, 'V'=>22, 'W'=>23, 'X'=>24, 'Y'=>25, 'Z'=>26,
);


mainProgram();
exit(0); 



sub mainProgram {

   my @names = ();
   
   if (! -e $sorted_file) {
      @names = sortAndSave();
   }
   else {
      my $INFILE = undef;
      open ($INFILE, $sorted_file) or die "Could not open $sorted_file for reading.\n$!\n";
      while(my $line = <$INFILE>) {
         chomp $line;
         push (@names, $line);
      }
      close ($INFILE);
   }
   
   my $total = Math::BigInt->new(0);
   foreach my $i (0..$#names) {
      my $v = nameValue($names[$i]);
      my $namescore = Math::BigInt->new($v)->bmul($i+1);
      $total->badd($namescore);
   }
   
   print $total->bstr()."\n";

}



sub nameValue {
   my $name = shift;
   my $retval = 0;
   foreach my $l (split(//, $name)) {
      $retval += $value{$l};
   }
   return $retval;
}

sub sortAndSave {
   my $INFILE = undef;
   my $OUTFILE = undef;
   my $contents = '';
   open ($INFILE, $input_file) or die "Could not open $input_file for reading.\n$!\n";
   while (<$INFILE>) {
      $contents .= uc($_);
   }
   close ($INFILE);
   
   #get rid of all whitespace
   $contents =~ s/\s//g;
   #get rid of leading and trailing "
   $contents =~ s/^\"//;
   $contents =~ s/\"$//;
   
   #split it into the names and sort it!
   my @names = sort split(/\"\,\"/, $contents);
   
   open ($OUTFILE, '>'.$sorted_file) or die "Could not open $sorted_file for writing.\n$!\n";
   foreach my $n (@names) {
      print $OUTFILE $n."\n";
   }
   close ($OUTFILE);
   
   return @names;
}




