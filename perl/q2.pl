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

        if ($c_string =~ m/[\*\/\+\-]/)
        {
            push @stack, $collector;
            push @stack, $c_string;
            $collector = "";
            next;
        }
        if ($c_string eq '(')
        {

            # should not be able to reach this point with anything in the collector.

            my $substring = substr($input, ($index));
            my $ret = parse_expression($substring);

            push @stack, $ret->{'stack'};
            $index += $ret->{'processed'};

            next;
        }
        if ($c_string eq ')')
        {
            push @stack, $collector;
            my $root;
            foreach my $el (@stack)
            {
                my $node = Node->new($el);
                if (!$root)
                {
                    $root = $node;
                }
                elsif ($node->is_operand() && $root->is_operand())})
                {
                    # node is an operand and root is an operand.
                    if ()
                }
                else
                {
                    if (defined $root->left())
                    {
                        $root->right($node);
                    }
                    else
                    {

                    }
                }
            }
            return { 'stack' => \@stack, 'processed' => $index };
        }
        $collector .= $c_string;
    }

    # need to do some checking here to see if there's an edge ccase not caught.
    if ($collector ne "")
    {
        push @stack, $collector;
    }
    return @stack;
}

sub build_tree(@)
{
    my @stack = shift;
    my $tree;
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
    build_tree parse_expression($altered);
}

f("1*(2+(3*(4+5)))");


package Node;
sub new
{
    my $class = shift;
    my $value = shift;
    my $self = {};
    bless $self, $class;
    $self->_initialize($value);
    return $self;
}

sub _initialize($)
{
    my $self = shift;
    $self->{parent} = undef;
    $self->{left} = undef;
    $self->{right} = undef;
    $self->{value} = shift;
    $self->{is_operand} = 0;
    $self->{order} = undef;
    if ($self->{value} =~ m/[\*\/\+\-]/)
    {
        $self->{is_operand} = 1;
        if ($self->{value} eq '*')
        {
            $self->{order} = 0;
        }
        if ($self->{value} eq '/')
        {
            $self->{order} = 1;
        }
        if ($self->{value} eq '+')
        {
            $self->{order} = 2;
        }
        if ($self->{value} eq '-')
        {
            $self->{order} = 3;
        }
    }
}

sub is_operand
{
    my $self = shift;
    return $self->{is_operand} == 1;
}

sub parent
{
    my $self = shift;
    my $parentRef = shift;
    if (!$parentRef)
    {
        return $self->{parent};
    }
    $self->{parent} = $parentRef;
}

sub left
{
    my $self = shift;
    my $leftRef = shift;
    if (!$leftRef)
    {
        return $self->{left};
    }
    $self->{left} = $leftRef;
}

sub right
{
    my $self = shift;
    my $rightRef = shift;
    if (!$rightRef)
    {
        return $self->{right};
    }
    $self->{right} = $rightRef;
}

1;