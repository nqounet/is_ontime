#!/usr/bin/env perl
use utf8;
use v5.12;
use Encode;

=promlem
---------------------------------------------------------------------
ある時刻(0時～23時)が、指定した時間の範囲内に含まれるかどうかを調べる
プログラムを作ってください。
言語は問いませんが、ライブラリなどを使ってはいけません。

得意な言語とPerlで2つ実装してください。
得意な言語がPerlである場合はPerlだけで構いません。

以下のような条件を満たすこと。
- ある時刻と、時間の範囲(開始時刻と終了時刻)を受け取る。
- 時刻は、6時であれば6のような指定でよく、分単位は問わない。
- 範囲指定は、開始時刻を含み、終了時刻は含まないと判断すること。
- ただし開始時刻と終了時刻が同じ場合は含むと判断すること。
- 開始時刻が22時で終了時刻が5時、というような指定をされても動作すること。
- 可読性、保守性、拡張性を考慮すること。
---------------------------------------------------------------------
=cut

my ($target, $begin, $end) = @ARGV;
test() if $target eq 'test';

my $result = is_ontime($target, $begin, $end);
if (defined $result) {
  if ($result) {
    say encode_utf8 qq{$target 時は $begin 時から $end 時の間に含まれる};
  }
  else {
    say encode_utf8 qq{$target 時は $begin 時から $end 時の間に含まれない};
  }
}
else {
  say encode_utf8 '入力が正しくありません';
  say encode_utf8 '使い方：'. $0 . ' targettime begintime endtime';
}

sub test {
  say test_is_ontime(1, 6, 0, 23);
  say test_is_ontime(1, 6, 6, 6);
  say test_is_ontime(0, 2, 6, 20);
  say test_is_ontime(0, 20, 6, 20);
  say test_is_ontime(1, 2, 22, 5);
  say test_is_ontime(0, 9, 22, 5);
  say test_is_ontime(undef, -1, 0, 23);
  say test_is_ontime(undef, 6, 0.1, 23);
  say test_is_ontime(undef, 6, 0, 25);
  say test_is_ontime(undef, '', '', '');
  say test_is_ontime(undef, undef, undef, undef);
  exit;
}

sub test_is_ontime {
  my ($test, $target, $begin, $end) = @_;
  my $result = is_ontime($target, $begin, $end);
  if (defined $result) {
    return $result == $test ? 'OK' : 'NG';
  }
  else {
    if (defined $test) {
      return 'NG';
    }
    else {
      return 'OK';
    }
  }
  die;
}

# エラー時は未定義
# 含む場合は1
# 含まない場合は0
# を返す
# usage: is_ontime($target, $begin, $end);
sub is_ontime {
  my ($target, $begin, $end) = @_;
  return unless validate($target);
  return unless validate($begin);
  return unless validate($end);

  if ($target == $begin) {
    return 1;
  }
  if ($end < $begin) {
    $target += 24;
    $end += 24;
  }
  if ($target >= $begin and $target < $end) {
    return 1;
  }
  return 0;
}

# 0から23の整数であることを確認する
# 正しい場合は真
# 正しくない場合は偽を返す
sub validate {
  my ($num) = @_;
  return if $num eq '';
  return if $num =~ /[^0-9]/;
  return if $num < 0;
  return if $num > 23;
  return 1;
}
