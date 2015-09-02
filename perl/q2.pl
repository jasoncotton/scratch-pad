#!/usr/bin/perl
use strict;
require 'ExpressionParser.pm';
local $| = 1;

# function removes any unneeded parens.  Means we need to parse the data by order of operations to determine
# what is and isn't needed.
sub f($)
{
    my $input = shift;
    my $altered = $input;

    # Clean up the string before processing
    $altered =~ s/\s//g;
    my $altered_length = length $altered;
    my $i = 0;
    my $collector = "";
    my @stack = ();

    $altered = ExpressionParser::remove_unneeded_parentheses($altered);
    print "original: \"" . $input . "\" and with parentheses removed: \"" . $altered . "\"\n";
    return $altered;
}

print "Welcome to my command loop! Enter in an expression and this program will attempt to remove any unneeded parentheses.\nType 'quit' or 'exit' to quit\n";
print "Enter an expression:\n";
while(<STDIN>)
{
    chomp;
    if ($_ eq 'quit' || $_ eq 'exit')
    {
       last;
    }
    print "The result was : ";
    f($_);
    print "Enter an expression (exit/quit to exit):\n";
};
