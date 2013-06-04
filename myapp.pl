#!/usr/bin/env perl
# use Devel::KYTProf; Devel::KYTProf->threshold(100);

use utf8;
use strict;
use warnings;
use lib 'lib';
use MyApp;
use Encode;
use Carp::Always;


my $app = MyApp->new;

my ($target, $begin, $end) = @ARGV;

my $result = $app->is_ontime($target, $begin, $end);
if (defined $result) {
  if ($result) {
    say encode_utf8(
      qq{$target 時は $begin 時から $end 時の間に含まれる});
  }
  else {
    say encode_utf8(
      qq{$target 時は $begin 時から $end 時の間に含まれない});
  }
}
else {
  say encode_utf8('入力が正しくありません');
  say encode_utf8('使い方：' . $0 . ' targettime begintime endtime');
}
