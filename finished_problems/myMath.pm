package myMath;
use strict;
use warnings;
use Data::Dumper;


our $prime_file = 'primes.txt';
our @primes = ();
##############################################################
# Sub          initializePrimeList
# Usage        initializePrimeList($max)
#              
# Parameters   $max = the maximum prime you want to initialize to
#              
# Description  This loads prime numbers from the prime number file.
#              Doing this will help speed up factoring, and prime number testing.
#              It's strongly recommended that you call this if you call this
#              at the beginning of your program, if you plan on doing much with
#              factoring or prime number testing.
#
#              If the requested $max is less than the largest number in the primes
#              file, you will be prompted on whether or not you want to continue
#              to calculate the needed primes.  If you do, those calculations will
#              be saved in primes.txt so that you don't have to calculate them again.
#
#              If you're not sure what the largest prime you'll need is, find the 
#              largest value that you might be testing, and take the square root of it.
#              That's the largest prime you'll need.
#
#     NOTE: Technically, this loads the next highest prime number after $max
#           This is done just to make sure that we do, in fact, have all the 
#           prime numbers less than $max.
#              
# Returns      1 (true) always
##############################################################
sub initializePrimeList {
   my $max = shift || 0;
   
   my $find_more = 0;
   @primes = ();
   
   eval {
      my $INFILE = undef;
      open ($INFILE, $prime_file) or die "could not open $prime_file for reading.\n$!\n";
      my $keep_going = 1;
      while ($keep_going) {
         my $line = <$INFILE>;
         if (defined $line) {
            chomp $line;
            push (@primes, $line);
            if ($line > $max) {
               $keep_going = 0;
            }
         }
         else {
            $keep_going = 0;
            $find_more = 1;
         }
      }
      close ($INFILE);
   };
   if ($@) {
      warn $@."\n";
      $find_more = 1;
   }
   
   
   #If we weren't able to load past the max, do the calculations
   # and store the results in the primes file
   if ($find_more) {
      my @new = ();
      
      my $last_prime = $primes[-1] || 1;
      
      if ($last_prime < 7) {
         if (! -e $prime_file) {
            my $OUTFILE = undef;
            open ($OUTFILE, '>'.$prime_file) or die "Could not open $prime_file for writing.\n$!\n";
            print $OUTFILE "2\n3\n5\n7\n";
            close ($OUTFILE);
         }
         else {
            die "The prime file ($prime_file) exists, but the last prime we could ".
                "load was less than 7.  Rather than overwriting the file, I'm dieing ".
                "so that the problem can be investigated.\n";
         }
         $last_prime = 7;
         @new = (2, 3, 5, 7);
      }

      
      require Prompt;
      print "$prime_file only contains the primes up to $last_prime.\n"
            ."The primes between $last_prime and $max must be calculated.\n"
            ."This may take some time.\n"
         ;
      my $continue = Prompt::prompt("Do you wish to contininue? ", 'n');
      if ($continue !~ /^[yY](?:[eE][sS])?$/) {
         die "calculation aborted\n";
      }
      else {
         print "Calculating more primes.\n";
      }
      
      my $cur = $last_prime + 2;
      #I'm looping while last_prime is less than max so that we
      #can find the next prime bigger than max
      #This makes it so that it's the same behavior as loading from the file.
      while ($last_prime < $max) {
         if (isPrime($cur)) {
            push (@new, $cur);
            $last_prime = $cur;
            if ($#new % 100 == 0) {
               print "New prime #".$#new." = $cur\n";
            }
         }
         $cur += 2;
      }
      
      #finally, add all the new ones to both the @primes list and the file
      my $OUTFILE = undef;
      open ($OUTFILE, '>>'.$prime_file) or die "Could not open $prime_file for append.\n$!\n";
      foreach my $p (@new) {
         print $OUTFILE $p."\n";
         push (@primes, $p);
      }
      close($OUTFILE);
      
      print "done calculating primes.\n";
   }
   
   return 1;
}


##############################################################
# Sub          getPrimesBelow
# Usage        my @primes = getPrimesBelow($i);
#              
# Parameters   $i = the maximum the primes should be
#              
# Description  Gets a list of all primes less than $i
#              
# Returns      a list of numbers
##############################################################
sub getPrimesBelow {
   my $i = shift || 2;
   if ($#primes < 0 || $primes[-1] < $i) {
      initializePrimeList($i);
   }
   
   my @retval = ();
   foreach my $p (@primes) {
      if ($p < $i) {
         push (@retval, $p);
      }
      else {
         last;
      }
   }
   
   return @retval;
}


##############################################################
# Sub          factor
# Usage        my @factors = @{factor($i)};
#              
# Parameters   $i = the number to factor
#              
# Description  Finds the prime factors of $i (1 is not included)
#              
# Returns      a reference to a list of numbers
##############################################################
sub factor {
   my $f = shift || 1;
   my $done = 0;
   my $last_p = 0;
   my @retval = ();
   #first, use the loaded primes.
   foreach my $p (@primes) {
      $last_p = $p;
      if ($f % $p == 0) {
         push (@retval, $p);
         $f /= $p;
         redo;
      }
      elsif ($p * $p > $f) {
         push (@retval, $f);
         $done = 1;
         last;
      }
   }
   #if we're not done yet, do it the hard way
   if (!$done) {
      my $i = $last_p;
      if ($i <= 2) {
         while ($f % 2 == 0) {
            push (@retval, 2);
            $f /= 2;
         }
         $i = 3;
      }
      while ($i * $i <= $f) {
         if ($f % $i == 0) {
            push (@retval, $i);
            $f /= $i;
         }
         else {
            $i += 2;
         }
      }
      push (@retval, $f);
   }
   if ($retval[-1] == 1) {
      pop @retval;
   }
   return \@retval;
}


##############################################################
# Sub          factor_hash
# Usage        my %factors = %{factor_hash($i)};
#              
# Parameters   $i = the number to factor
#              
# Description  Finds the prime factors of $i (1 is not included)
#              
# Returns      a reference to a hash. 
#              The keys are the prime factors,
#              The values are the exponent for those factors.
##############################################################
sub factor_hash {
   my $i = shift;
   my %retval = ();
   foreach my $f (@{factor($i)}) {
      if (exists $retval{$f}) {
         $retval{$f} += 1;
      }
      else {
         $retval{$f} = 1;
      }
   }
   return \%retval;
}
   


##############################################################
# Sub          isPrime
# Usage        if (isPrime($i)) {...}
#              
# Parameters   $i = the number  to test
#              
# Description  Tests if the given number is prime
#              
# Returns      1 (true) if $i is prime
#              0 (false) if $i is not prime
##############################################################
sub isPrime {
   my $f = shift || 0;
   my $retval = 0;
   if ($f) {
      my $factors = factor($f);
      if ($#$factors == 0) {
         $retval = 1;
      }
   }
   return $retval;
}
#this was the old sub. It's here just in case I decide I want it.
sub isPrime_old {
   my $f = shift || 1;
   my $retval = 1;
   if ($f == 2) {
      $retval = 1;
   }
   elsif ($f % 2 == 0) {
      $retval = 0;
   }
   else {
      my $m = int(sqrt($f));
      my $done = 0;
      #first, use the loaded primes for testing
      foreach my $p (@primes) {
         if ($p > $m) {
            $done = 1;
            last;
         }
         if ($f % $p == 0) {
            $retval = 0;
            $done = 1;
            last;
         }
      }
      #now, if we still haven't reached the max devisor,
      # proceed the hard way
      if (!$done) {
         my $i = $primes[-1];
         if (! defined $i || $i == 2) {
            $i = 3;
         }
         while ($i <= $m) {
            if ($f % $i == 0) {
               $retval = 0;
               $i = $m + 1;
            }
            $i += 2;
         }
      }
   }
   return $retval;
}


##############################################################
# Sub          getDivisors
# Usage        my @div = @{getDivisors($i, $proper_flag)};
#              
# Parameters   $i = the number to get the divisors for
#              $proper_flag = set to true if you only want the proper divisors of $i
#                             default is 0 (false).
#              
# Description  Gets all of the divisors of $i.  
#              This includes 1, and, unless the $proper_flag is 
#               true, $i will be in the list too.
#              
# Returns      a reference to a list of numbers
##############################################################
sub getDivisors {
   my $f = shift || 1;
   my $p = shift || 0; #proper flag
   my @factors = @{factor($f)};
   my @retval = (1);
   foreach my $c (1..$#factors) {
      my $groups = getGroups(\@factors, $c);
      foreach my $g (@$groups) {
         my $p = 1;
         foreach my $v (@$g) {
            $p *= $v;
         }
         if (! grep { $p == $_ } @retval) {
            push (@retval, $p);
         }
      }
   }
   push (@retval, $f) unless($p);
   return \@retval;
}


##############################################################
# Sub          relativelyPrime
# Usage        if (relativelyPrime($n1, $n2)) { ... }
#              
# Parameters   $n1 = number 1
#              $n2 = number 2
#              
# Description  Tests if $n1 and $n2 are relatively prime.
#              That is, it tests to see if $n1 and $n2 have any
#              common factors other than 1.  It uses an advanced 
#              technique that should be faster than the naive approach.
#              
# Returns      1 (true) if relatively prime
#              0 (false) if the share a factor
##############################################################
sub relativelyPrime {
   my $big = shift;
   my $small = shift;
   if ($big < $small) {
      ($big, $small) = ($small, $big);
   }
   my $rem = $big % $small;
   while ($rem > 1) {
      $big = $small;
      $small = $rem;
      $rem = $big % $small;
   }
   return ($rem == 1) ? 1 : 0;
}


##############################################################
# Sub          getGroups
# Usage        my @groups = @{getGroups(\@list, $count)}
#              
# Parameters   \@list = a reference to a list
#              $count = the number of items you want in each list
#              
# Description  Gets all possible combinations of $count items in @list
#              
# Returns      a reference to a list of list refs.  Each sub list
#              will have items from @list.
##############################################################
sub getGroups {
   my $list = shift || [];
   my $count = shift || 1;
   #print "getGroups: count = $count\n".Dumper($list)."\n";
   my @retval = ();
   if ($count == 1) {
      foreach my $f (@$list) {
         push (@retval, [$f]);
      }
   }
   else {
      foreach my $i (0..($#$list-1)) {
         my @sublist = ();
         foreach my $j (($i+1)..$#$list) {
            push (@sublist, $list->[$j]);
         }
         my @subgroups = @{getGroups(\@sublist, $count-1)};
         foreach my $g (@subgroups) {
            push (@$g, $list->[$i]);
            push(@retval, $g);
         }
      }
   }
   return \@retval;
}


##############################################################
# Sub          sumPropDivs
# Usage        my $s = sumPropDivs($i);
#              
# Parameters   $i = the number in question
#              
# Description  gets the sum of the proper divisors of $i
#              
# Returns      a number
##############################################################
sub sumPropDivs {
   my $i = shift || 1;
   my $d = getDivisors($i, 1);
   my $retval = 0;
   foreach my $v (@$d) {
      $retval += $v;
   }
   return $retval;
}






1;
