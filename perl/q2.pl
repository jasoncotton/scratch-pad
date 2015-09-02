#!/usr/bin/perl
use strict;
use Data::Dumper;

local $| = 1;

sub build_tree($)
{
    my $stackRef = shift;
    my @stack = @$stackRef;
    my $root;
    my $i = scalar(@stack);

    while ($i--)
    {
        my $node = $stack[$i];

        if (defined $root)
        {
            if (defined $root->left() && defined $root->right())
            {
                $node->right($root);
                $root = $node;
            }
            elsif (defined $root->right())
            {
                $root->left($node);
            }
            else
            {
                # if we are in a leaf node (first run through) then presume that root shouldn't be root
                $node->right($root);
                $root = $node;
            }
        }
        else
        {
            $root = $node;
        }
    }
    return $root;
}

sub parse_expression($)
{
    my $input = shift;
    my $length = length $input;
    my @stack = ();
    my $index = 0;
    my $collector = "";
    my $last_was_operand = undef;
    my $tree;

    while ($index < $length)
    {
        my $c_string = substr $input, $index++, 1;

        if ($c_string =~ m/[\*\/\+\-]/)
        {
            if (defined $last_was_operand && $last_was_operand || !(defined $last_was_operand))
            {
                # if we encounter an operand before anything else or the last thing was an operand, assume that this thing is a negative sign
                if ($c_string eq '-')
                {
                    $collector .= $c_string;
                    next;
                }
            }
            push @stack, Node->new($collector);
            push @stack, Node->new($c_string);
            $collector = "";
            $last_was_operand = 1;
            next;
        }
        if ($c_string eq '(')
        {
            # should not be able to reach this point with anything in the collector.
            # clear it anyways
            $collector = "";

            my $substring = substr($input, ($index));
            my $ret = parse_expression($substring);

            push @stack, $ret->{'root'};
            $index += $ret->{'processed'};

            next;
        }
        if ($c_string eq ')')
        {
            if ($collector && $collector ne "")
            {
                push @stack, Node->new($collector);
            }
            return { 'stack' => \@stack, 'processed' => $index, 'root' => build_tree(\@stack) };
        }
        $collector .= $c_string;
    }

    # need to do some checking here to see if there's an edge case not caught.
    if ($collector && $collector ne "")
    {
        push @stack, Node->new($collector);
    }
    print Data::Dumper::Dumper(build_tree(\@stack));
    return @stack;
}

sub rebuild_expression($)
{
    my $root = shift;
    my $node;
    my $i;
    my $expression = "";

    $node = $root;
    while (defined $node)
    {
        if ($node->left())
        {
            $node = $node->left();
        }
        elsif ($node->right())
        {
            # The way this code is written, we never have a right node without a left node.
            # Nothing happens at this point.
        }
        else
        {
            $expression .= $node->value();
            if ($node->parent() && $node->parent()->right())
            {
                $expression .= $node->parent()->value();
                $node = $node->parent()->right();
            }
            else
            {
                last;
            }
        }
    }
    print "Expression: " . $expression;
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

    rebuild_expression parse_expression($altered);
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
    if (!(defined $leftRef))
    {
        return $self->{left};
    }
    $self->{left} = $leftRef;
    $leftRef->parent($self);
}

sub right
{
    my $self = shift;
    my $rightRef = shift;
    if (!(defined $rightRef))
    {
        return $self->{right};
    }
    $self->{right} = $rightRef;
    $rightRef->parent($self);
}

1;
