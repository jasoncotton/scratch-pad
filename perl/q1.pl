#!/usr/bin/perl

use Data::Dumper;

sub has_lowercase($)
{
  my $input = shift;
  return $input =~ m/[a-z]/;
}

sub has_uppercase($)
{
  my $input = shift;
  return $input =~ m/[A-Z]/;
}

sub has_number($)
{
  my $input = shift;
  return $input =~ m/\d/;
}

sub has_symbol($)
{
  my $input = shift;
  return $input =~ m/[!\@#\$%^&*()=+_;:'"\[\]\{\}\\|,<\.>\/\?`~-]/;
}

sub is_valid_password($)
{
  my $passwd = shift;
  my $passwd_length = length $passwd;
  my $result = 1;

  if ($passwd_length < 12)
  {
    $result = $result && has_symbol($passwd);
  }
  if ($passwd_length < 16)
  {
    $result = $result && has_number($passwd);
  }
  if ($passwd_length < 20)
  {
    $result = $result && has_uppercase($passwd) && has_lowercase($passwd);
  }
  return $result;
}



my @tests = qw{
  a
  aa
  aaaa
  aaaaaaaa
  a1aaaaaa
  a1!aaaaa
  A1!aaaaa
  aaaaaaaaaaa
  11111111111
  aaaaaaaaaaaa
  111111111111
  aaaaaaaaaaaaaaa
  111111111111111
  aaaaaaaaaaaaaaaa
  1111111111111111
  aaaaaaaaaaaaaaaaaaa
  1111111111111111111
  aaaaaaaaaaaaaaaaaaaa
  11111111111111111111
};

foreach (@tests)
{
  print $_, " ", Dumper(is_valid_password($_));

}

  
