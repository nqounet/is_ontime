package MyApp;

use Mojo::Base -base;

# Profile of myapp.pl for 39.4ms (of 39.9ms), executing 1771 statements and 398 subroutine calls in 27 source files and 4 string evals.

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

  if ($target == $begin) {
    return 1;
  }
  if ($end < $begin) {
    $end += 24;
    $target += 24 if $target < $begin;
  }
  if ($target >= $begin and $target < $end) {
    return 1;
  }
  return 0;
}

# 0から23の整数であることを確認する
# 正しい場合は真
# 正しくない場合は偽を返す
sub _validate {
  my ($num) = @_;
  return unless defined $num;
  return if $num eq '';
  return if $num =~ /[^0-9]/;
  return if $num < 0;
  return if $num > 23;
  return 1;
}

1;
