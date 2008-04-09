use strict;
use warnings;
use Test::More tests => 11;
use Test::Exception;

use methods qw(foo bar);

{ package A; sub foo { shift; join ',', 'foo', @_ } }
{ package C; sub bar { shift; join ',', 'bar', @_ } }

my $a = bless {} => 'A'; # no B because it's the compiler
my $c = bless {} => 'C';

# make sure the normal means work
ok $a;
ok $c;
is $a->foo('bar'), 'foo,bar';
is $c->bar('bar'), 'bar,bar';
throws_ok { $a->bar } qr{Can't locate object method "bar" via package "A"};
throws_ok { $c->foo } qr{Can't locate object method "foo" via package "C"};

# now make sure our super special methods work
my $foo = foo $a, 'with', 'some', 'args';
is $foo, 'foo,with,some,args';
is bar($c,'hi'), 'bar,hi';

throws_ok { foo 'what the fuck' } qr {Can't locate object method "foo" via package "what the fuck"};
throws_ok { foo $c } qr{Can't locate object method "foo" via package "C"};
throws_ok { &foo } qr{Can't call method "foo" on an undefined value};
