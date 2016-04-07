package Prompt;

use strict;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(prompt);
our @EXPORT_OK = qw(prompt promptYesNo debugPrintWait debugPrint debugWait);

##############################################################
# Sub          prompt
# Usage        my $input = prompt($string, $default)
#
# Parameters   $string = the string to output that indicates to the user
#                        that they are being asked for input
#              $default = the default return value (if the user just
#                         presses enter).
#
# Description  Prompts the user for some input.
#              If no default is given, the prompt looks like this:
#              "$string: "
#              Otherwise it looks like this:
#              "$string[$default]: '
#
# Returns      the input
##############################################################
sub prompt {
   my $promptString = shift || '>>';
   my $defaultValue = shift;
   if (! defined $defaultValue) {
      $defaultValue = '';
   }

   if ($defaultValue) {
      print $promptString. '['. $defaultValue. ']: ';
   }
   else {
      print $promptString. ': ';
   }

   $| = 1;  #flush buffer so the printed lines above show up
   my $buff = <STDIN>;

   chomp $buff;   #remove the newline entered by the user

   my $retval = $buff ? $buff : $defaultValue;

   return $retval;
}


##############################################################
# Sub          promptYesNo
# Usage        my $input = promptYesNo($string, $default)
#
# Parameters   $string = the string to output that indicates to the user
#                        that they are being asked for input.
#                        defaults to "Yes or No?"
#              $default = the default return value (if the user just
#                         presses enter).
#                         1 for a default of yes
#                         0 for a default of no
#                         undef for no default
#
# Description  Prompts the user for yes/no input.
#              If no default is given, the prompt looks like this:
#              "$string: "
#              Otherwise it looks like this:
#              "$string[$default]: '
#
# Returns      1 if the user selected yes, 0 if the user selected no
##############################################################
sub promptYesNo {
   my $promptString = shift || 'Yes or No';
   my $defaultValue = shift;
   
   $promptString =~ s/\s+$//;
   my $fullprompt = $promptString
                   .(   
                       ! defined $defaultValue ? ''
                     : $defaultValue ? '[yes]'
                     : ' [no]'
                   ).'? '
               ;
   
   my $retval = undef;
   while (! defined $retval) {
      print $fullprompt;
      $| = 1;  #flush buffer so the printed lines above show up
      
      my $buff = <STDIN>;
      
      if ((! $buff || $buff !~ /\S/) && defined $defaultValue) {
         $retval = $defaultValue;
      }
      elsif (defined $buff && $buff =~ /[yY]/) {
         $retval = 1;
      }
      elsif (defined $buff && $buff =~ /[nN]/) {
         $retval = 0;
      }
      else {
         print 'Invalid response. Please use "yes" or "no".'."\n";
      }
   }

   return $retval;
}


##############################################################
# Sub          debugPrintWait
# Usage        debugPrintWait($debug_flag, $message);
#              
# Parameters   $debug_flag = flag, set to true to print the message and wait for enter to be pressed.
#              $message = The thing to print
#              
# Description  If the given debug_flag is set, it prints a message and waits for enter to be pressed.
#              
# Returns      1 (true) always
##############################################################
sub debugPrintWait {
   my $debug = shift;
   my $message = shift;
   if ($debug) {
      $message =~ s/\n$//;   #ensure no line ending (it's added by the user!)
      print $message;
      $| = 1;
      my $tosser = <STDIN>;
   }
   return 1;
}


##############################################################
# Sub          debugPrint
# Usage        debugPrint($debug_flag, $message);
#              
# Parameters   $debug_flag = flag, set to true to print the message and wait for enter to be pressed.
#              $message = The thing to print
#              
# Description  If the given debug_flag is set, it prints a message.
#              
# Returns      1 (true) always
##############################################################
sub debugPrint {
   my $debug = shift;
   my $message = shift;
   if ($debug) {
      $message =~ s/\n?$/\n/;   #ensure a line ending.
      print $message;
   }
   return 1;
}

##############################################################
# Sub          debugWait
# Usage        debugWait($debug_flag, $message);
#              
# Parameters   $debug_flag = flag, set to true to print the message and wait for enter to be pressed.
#              $message = The thing to print
#              
# Description  If the given debug_flag is set, waits for enter to be pressed.
#              
# Returns      1 (true) always
##############################################################
sub debugWait {
   my $debug = shift;
   my $message = shift;
   if ($debug) {
      $| = 1;
      my $tosser = <STDIN>;
   }
   return 1;
}


1;

