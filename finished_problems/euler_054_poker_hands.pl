#!/usr/bin/perl
use strict;
use warnings;
use lib qw(.);
use myMath;
use Math::BigInt;
use Data::Dumper;


my $fn = 'poker.txt';

my %value_map = (
   T => 10, J => 11, Q => 12, K => 13, A => 14,
);
foreach my $i (2..9) {
   $value_map{$i} = $i;
}

mainProgram();
exit(0); 



sub mainProgram {

   my $p1win = 0;
   my $p2win = 0;
   my $draw = 0;
   
   my $INFILE = undef;
   open ($INFILE, $fn) or die "Could not open $fn for reading.\n$!\n";
   while (my $line = <$INFILE>) {
      my @cards = split(/\s+/, $line);
      my @hand1 = ();
      my @hand2 = ();
      foreach my $i (0..4) {
         my ($val, $suit) = split(//, $cards[$i]);
         push (@hand1, { value => $value_map{$val}, suit => $suit, card => $cards[$i] } );
      }
      foreach my $i (5..9) {
         my ($val, $suit) = split(//, $cards[$i]);
         push (@hand2, { value => $value_map{$val}, suit => $suit, card => $cards[$i] } );
      }
      @hand1 = sort {$b->{value} <=> $a->{value}} @hand1;
      @hand2 = sort {$b->{value} <=> $a->{value}} @hand2;
      my ($name1, $h1) = calculateRank(\@hand1);
      my ($name2, $h2) = calculateRank(\@hand2);
      my @c1 = ();
      my @c2 = ();
      foreach my $c (@hand1) {
         push (@c1, $c->{card});
      }
      foreach my $c (@hand2) {
         push (@c2, $c->{card});
      }
      print substr((' 'x15).$name1, -15).': '.join(' ', @c1).' = '.substr((' 'x6).$h1, -6);
      if ($h1 == $h2) {
         $draw += 1;
         print "====";
      }
      elsif ($h1 < $h2) {
         $p1win += 1;
         print "<<  ";
      }
      elsif ($h2 < $h1) {
         $p2win += 1;
         print "  >>";
      }
      print substr($h2.(' 'x6), 0, 6).' = '.join(' ', @c2).' :'.substr($name2.(' 'x15), 0, 15)."\n";
      #my $indkfjeijfd = <STDIN>;
   }
   close($INFILE);
   
   print "p1 wins: $p1win\n".
         "p2 wins: $p2win\n".
         "  draws: $draw\n".
         "p1 doesn't win: ".($p2win + $draw)."\n".
         "p2 doesn't win: ".($p1win + $draw)."\n";


}


sub calculateRank {
   my $hand = shift;
   
   my $retval = 0;
   my $name = '';
   if (my @z = isRoyalFlush($hand)) {
      $retval = $z[0];
      $name = 'Royal Flush';
   }
   elsif (my @y = isStraightFlush($hand)) {
      $retval = 2 + 13 - $y[0];
      $name = 'Straight Flush';
   }
   elsif (my @x = isFourOfAKind($hand)) {
      $retval = 11 + 196 - ($x[0] * 13 + $x[1]);
      $name = 'Four of a Kind';
   }
   elsif (my @w = isFullHouse($hand)) {
      $retval = 250 + 196 - ($w[0] * 13 + $w[1]);
      $name = 'Full House';
   }
   elsif (my @v = isFlush($hand)) {
      $retval = 500 + 260414 - (((($v[0] * 13 + $v[1]) * 12 + $v[2] ) * 11 + $v[3]) * 10 + $v[4]);
      $name = 'Flush';
   }
   elsif (my @u = isStraight($hand)) {
      $retval = 300000 + 14 - $u[0];
      $name = 'Straight';
   }
   elsif (my @t = isThreeOfAKind($hand)) {
      $retval = 300020 + 2366 - (($t[0] * 13 + $t[1]) * 12 + $t[2]);
      $name = 'Three of a Kind';
   }
   elsif (my @s = isTwoPair($hand)) {
      $retval = 302500 + 2366 - (($s[0] * 13 + $s[1]) * 12 + $s[2]);
      $name = 'Two Pair';
   }
   elsif (my @r = isPair($hand)) {
      $retval = 305000 + 26040 - ((($r[0] * 13 + $r[1]) * 12 + $r[2] ) * 11 + $r[3]);
      $name = 'Pair';
   }
   elsif (my @q = highCard($hand)) {
      $retval = 350000 + 260414 - (((($q[0] * 13 + $q[1]) * 12 + $q[2] ) * 11 + $q[3]) * 10 + $q[4]);
      $name = 'High Card';
   }
   else {
      print "wtf? It shouldn't be here!\n".join(' ', @$hand)."\n";
      $name = '**FUBAR**';
   }
    
   return ($name, $retval);
}


sub isRoyalFlush {
   my $hand = shift;
   my @retval = ();
   if (my @v = isStraightFlush($hand)) {
      if ($v[0] == 14) {
         @retval = (1, 0, 0, 0, 0);
      }
   }
   return @retval;
}

sub isStraightFlush {
   my $hand = shift;
   my @retval = ();
   if (my @flush_v = isFlush($hand)) {
      if (my @straight_v = isStraight($hand)) {
         @retval = @straight_v;
      }
   }
   return @retval;
}

sub isFourOfAKind {
   my $hand = shift;
   my @retval = ();
   my %vals = ();
   foreach my $card (@$hand) {
      $vals{$card->{value}} += 1;
   }
   my $main_val = 0;
   my $high_card = 0;
   foreach my $v (keys %vals) {
      if ($vals{$v} >= 4) {
         $main_val = $v;
      }
      else {
         if ($v > $high_card) {
            $high_card = $v;
         }
      }
   }
   if ($main_val && $high_card) {
      @retval = ($main_val, $high_card, 0, 0, 0);
   }
   return @retval;
}

sub isFullHouse {
   my $hand = shift;
   my @retval = ();
   my %vals = ();
   foreach my $card (@$hand) {
      $vals{$card->{value}} += 1;
   }
   my $three = 0;
   my $two = 0;
   foreach my $v (keys %vals) {
      if ($vals{$v} == 3) {
         $three = $v;
      }
      elsif ($vals{$v} == 2) {
         $two = $v;
      }
      else {
         last;
      }
   }
   if ($three && $two) {
      @retval = ($three, $two, 0, 0, 0);
   }
   return @retval;
}

sub isFlush {
   my $hand = shift;
   my @retval = ();
   if ($hand->[0]->{suit} eq $hand->[1]->{suit}
    && $hand->[0]->{suit} eq $hand->[2]->{suit}
    && $hand->[0]->{suit} eq $hand->[3]->{suit}
    && $hand->[0]->{suit} eq $hand->[4]->{suit}
   ) {
      @retval = highCard($hand);
   }
   return @retval;
}

sub isStraight {
   my $hand = shift;
   my $dont_check_high_ace = shift || 1;  #they do it wrong :(
   my @retval = ();
   if ($hand->[0]->{value} - 1 == $hand->[1]->{value}
    && $hand->[1]->{value} - 1 == $hand->[2]->{value}
    && $hand->[2]->{value} - 1 == $hand->[3]->{value}
    && $hand->[3]->{value} - 1 == $hand->[4]->{value}
   ) {
      @retval = ($hand->[0]->{value}, 0, 0, 0, 0);
   }
   elsif (! $dont_check_high_ace) {
      #if the highest card is an ace, swap it to the low ace and see if that helps
      my @newhand = ($hand->[1], $hand->[2], $hand->[3], $hand->[4]);
      push (@newhand, { value => 1, suit => $hand->[0]->{suit}, card => $hand->[0]->{card} });
      if (my @straight = isStraight(\@newhand, 1)) {
         @retval = @straight;
      }
   }
   return @retval;
}

sub isThreeOfAKind {
   my $hand = shift;
   my @retval = ();
   my %vals = ();
   foreach my $card (@$hand) {
      $vals{$card->{value}} += 1;
   }
   my $three = 0;
   my @high_cards = ();
   foreach my $v (keys %vals) {
      if ($vals{$v} == 3) {
         $three = $v;
      }
      else {
         push (@high_cards, $v);
      }
   }
   if ($three && scalar(@high_cards) >= 2) {
      @high_cards = sort {$b <=> $a} @high_cards;
      @retval = ($three, $high_cards[0], $high_cards[1], 0, 0);
   }
   return @retval;
}

sub isTwoPair {
   my $hand = shift;
   my @retval = ();
   my %vals = ();
   foreach my $card (@$hand) {
      $vals{$card->{value}} += 1;
   }
   my @pairs = ();
   my $high_card = 0;
   foreach my $v (keys %vals) {
      if ($vals{$v} == 2) {
         push (@pairs, $v);
      }
      else {
         if ($v > $high_card) {
            $high_card = $v;
         }
      }
   }
   if ((scalar @pairs) >= 2 && $high_card) {
      @pairs = sort {$b <=> $a} @pairs;
      @retval = ($pairs[0], $pairs[1], $high_card, 0, 0);
   }
   return @retval;
}

sub isPair {
   my $hand = shift;
   my @retval = ();
   my %vals = ();
   foreach my $card (@$hand) {
      $vals{$card->{value}} += 1;
   }
   my $two = 0;
   my @high_cards = ();
   foreach my $v (keys %vals) {
      if ($vals{$v} == 2) {
         $two = $v;
      }
      else {
         push (@high_cards, $v);
      }
   }
   if ($two && scalar(@high_cards) >= 3) {
      @high_cards = sort {$b <=> $a} @high_cards;
      @retval = ($two, $high_cards[0], $high_cards[1], $high_cards[2], 0);
   }
   return @retval;
}

sub highCard {
   my $hand = shift;
   my @retval = ();
   foreach my $card (@$hand) {
      push (@retval, $card->{value});
   }
   @retval = sort {$b <=> $a} @retval;
   return @retval;
}

