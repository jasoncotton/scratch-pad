package ExpressionParser;

use strict;
use Exporter;
require 'ExpressionNode.pm';
use Data::Dumper;

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

@EXPORT = ();
@EXPORT_OK = qw(remove_unneeded_parentheses);

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

    print Data::Dumper::Dumper($input);

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
            push @stack, ExpressionNode->new($collector);
            push @stack, ExpressionNode->new($c_string);
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
                push @stack, ExpressionNode->new($collector);
            }
            return { 'stack' => \@stack, 'processed' => $index, 'root' => build_tree(\@stack) };
        }
        $collector .= $c_string;
    }

    # need to do some checking here to see if there's an edge case not caught.
    if ($collector && $collector ne "")
    {
        push @stack, ExpressionNode->new($collector);
    }
    return build_tree(\@stack);
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
        if ($node->is_operand() && $node->parent() && $node->parent()->order() < $node->order())
        {
            $expression .= "(" . rebuild_expression($node->clone()) . ")";
            last;
        }

        if ($node->left())
        {
            $node = $node->left();
        }
        else
        {
            $expression .= $node->value();
            $expression .= $node->parent()->value();
            $node = $node->parent()->right();
            if (!$node->left())
            {
                $expression .= $node->value();
                last;
            }
        }
    }
    return $expression;
}

sub remove_unneeded_parentheses($)
{
    return rebuild_expression(parse_expression($altered));
}

1;