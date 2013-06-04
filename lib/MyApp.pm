package MyApp;
use strict;
use warnings;
our $VERSION = "0.01";

sub new { bless +{}, shift }

# Profile of myapp.pl for 24.2ms (of 24.5ms), executing 1444 statements and 328 subroutine calls in 21 source files and 2 string evals.

# use Mojo::Base -base;
# Profile of myapp.pl for 37.4ms (of 37.8ms), executing 1771 statements and 398 subroutine calls in 27 source files and 4 string evals.

# use Mo;
# Profile of myapp.pl for 29.4ms (of 29.8ms), executing 1473 statements and 333 subroutine calls in 22 source files and 2 string evals.

# use Moo;
# Profile of myapp.pl for 47.3ms (of 47.9ms), executing 2648 statements and 908 subroutine calls in 36 source files and 6 string evals.

# use Mouse;
# Profile of myapp.pl for 53.0ms (of 53.7ms), executing 3075 statements and 548 subroutine calls in 34 source files and 4 string evals.

# use Moose;
# Profile of myapp.pl for 715ms (of 749ms), executing 113714 statements and 52974 subroutine calls in 119 source files and 181 string evals.


# エラー時は未定義
# 含む場合は1
# 含まない場合は0
# を返す
# usage: is_ontime($target, $begin, $end);
sub is_ontime {
  my ($self, $target, $begin, $end) = @_;
  return unless _validate($target);
  return unless _validate($begin);
  return unless _validate($end);

  return 1 if $target == $begin;

  my @ontime = (0 .. 23);

  if ($end < $begin) {
    my @temp = splice @ontime, $begin;
    push @temp, splice(@ontime, 0, $end);
    @ontime = @temp;
  }
  else {
    @ontime = splice @ontime, $begin, $end - $begin;
  }

#  warn "$begin to $end is [@ontime]";
  return $target ~~ @ontime ? 1 : 0;
}

# 0から23の整数であることを確認する
# 正しい場合は真
# 正しくない場合は偽を返す
sub _validate {
  my ($num) = @_;
  return if $num eq '';
  my @valid = (0 .. 23);
  return $num ~~ @valid ? 1 : 0;
}

1;
__END__

=encoding utf-8

=head1 NAME

MyApp - is ontime

=head1 SYNOPSIS

    use MyApp;

=head1 DESCRIPTION

MyApp is ...

=head1 LICENSE

Copyright (C) nqounet.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

nqounet E<lt>nqou.net@gmail.comE<gt>

=cut

