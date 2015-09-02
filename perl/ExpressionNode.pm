package ExpressionNode;

sub new
{
    my $class = shift;
    my $value = shift;
    my $self = {};
    bless $self, $class;
    $self->_initialize($value);
    $self->{class} = $class;
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

sub order
{
     my $self = shift;
     return $self->{order};
}

sub value
{
    my $self = shift;
    return $self->{value};
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
print ref($rightRef);
    $self->{right} = $rightRef;
    $rightRef->parent($self);
}

sub clone
{
    my $self = shift;
    my $clone = ExpressionNode->new($self->value());
    if ($self->left())
    {
        $clone->left($self->left()->clone());
    }
    if ($self->right())
    {
        $clone->right($self->right()->clone());
    }
    return $clone;
}

1;
