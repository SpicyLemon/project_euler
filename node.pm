package node;
use strict;
use warnings;
use Data::Dumper;

##############################################################
# Sub          new
# Usage        $dd = node->new($value, $left, $right, $info)
#
# Parameters   $value = the value that the new node should have
#              $left  = the left node
#              $right = the right node
#              $info  = the extra info
#           note: all parameters are optional and default to undef
#
# Description  Constructor for a new node object
#
# Returns      a new node object
##############################################################
sub new {
   my $proto = shift;
   my $value = shift || undef;
   my $left  = shift || undef;
   my $right = shift || undef;
   my $info  = shift || undef;
   
   my $class = ref($proto) || $proto;
   my $self = {
      _value => undef,
      _left =>  undef,   #points to left node
      _right => undef,  #points to right node
      _info =>  undef,   #any extra info you want to store about this node
   };
   bless($self, $class);
   
   if (defined $value) {
      $self->setValue($value);
   }
   if (defined $left) {
      $self->setLeft($left);
   }
   if (defined $right) {
      $self->setRight($right);
   }
   if (defined $info) {
      $self->setInfo($info);
   }
   
   return $self;
}




##################################################
sub getValue {
   my $self = shift;
   return $self->{_value};
}

sub setValue {
   my $self = shift;
   $self->{_value} = shift;
   return $self->{_value};
}

##################################################
sub getRight {
   my $self = shift;
   return $self->{_right};
}

sub setRight {
   my $self = shift;
   my $new_right = shift;
   if (UNIVERSAL::isa($new_right, 'node')) {
      $self->{_right} = $new_right;
   }
   else {
      print Dumper($new_right)."\nis not a node\n";
   }
   return $self->{_right};
}

##################################################
sub getLeft {
   my $self = shift;
   return $self->{_left};
}

sub setLeft {
   my $self = shift;
   my $new_left = shift;
   if (UNIVERSAL::isa($new_left, 'node')) {
      $self->{_left} = $new_left;
   }
   else {
      print Dumper($new_left)."\nis not a node\n";
   }
   return $self->{_left};
}

##################################################
sub getInfo {
   my $self = shift;
   return $self->{_info};
}

sub setInfo {
   my $self = shift;
   $self->{_info} = shift;
   return $self->{_info};
}


1;