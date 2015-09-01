#!/usr/bin/perl


# function removes any unneeded parens.  Means we need to parse the data by order of operations to determine
# what is and isn't needed.
sub f($)
{
  my $input = shift;


}

# math operators:
# +
# - (subtraction)
# *
# / (division)
# () (parens)

# has to allow for numbers or symbols => (letters)
# example input:
1 * ( 2 + ( 3 * ( 4 + 5 ) ) )

# need to leave white space alone in the end...

    *
  /   \
1      ()
      /   \
    2