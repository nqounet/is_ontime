use Test::More;

use_ok('MyApp');

my $t = MyApp->new;

is($t->is_ontime(6,     0,     23),    1,     'ok - 6, 0, 23');
is($t->is_ontime(6,     6,     6),     1,     'ok - 6, 6, 6');
is($t->is_ontime(2,     6,     20),    0,     'ng - 2, 6, 20');
is($t->is_ontime(20,    6,     20),    0,     'ng - 20, 6, 20');
is($t->is_ontime(2,     22,    5),     1,     'ok - 2, 22, 5');
is($t->is_ontime(23,    22,    5),     1,     'ok - 23, 22, 5');
is($t->is_ontime(9,     22,    5),     0,     'ng - 9, 22, 5');
is($t->is_ontime(-1,    0,     23),    undef, 'error - -1, 0, 23');
is($t->is_ontime(6,     0.1,   23),    undef, 'error - 6, 0.1, 23');
is($t->is_ontime(6,     0,     25),    undef, 'error - 6, 0, 25');
is($t->is_ontime('',    '',    ''),    undef, q{error - '', '', ''});
is($t->is_ontime(undef, undef, undef), undef, 'error - undef, undef, undef');

done_testing;
