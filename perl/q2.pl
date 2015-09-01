#!/usr/bin/perl
use strict;
use Data::Dumper;

local $| = 1;

sub parse_expression($)
{
    my $input = shift;
    print "inside of parse_expression: $input\n";
    my $length = length $input;
    my @stack = ();
    my $index = 0;
    my $collector = "";

    while ($index < $length)
    {
        my $c_string = substr $input, $index++, 1;

        if ($c_string =~ m/\*\/\+\-/)
        {
            push @stack, $collector;
            push @stack, $c_string;
            next;
        }
        if ($c_string eq '(')
        {
            my $substring = substr($input, ($index));
            my $ret = parse_expression($substring);
            print Data::Dumper($ret);
            push @stack, $ret->{'stack'};
            $index += $ret->{'processed'};
            next;
        }
        if ($c_string eq ')')
        {
            return { 'stack' => \@stack, 'processed' => $index };
        }
        $collector .= $c_string;
    }
}

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

    print "about to parse string: $altered\n";
    parse_expression($altered);
}


f("1*(2+(3*(4+5)))");