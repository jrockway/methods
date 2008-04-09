package methods;
use strict;
use warnings;
use Carp qw(confess);

sub import {
    my $caller  = scalar caller;
    my $class   = shift;
    my @methods = @_;

    confess 'No methods to install?' unless @methods;

    for my $method (@methods){
        no strict 'refs';
        *{ $caller. '::'. $method } = sub($;@) {
            my $invocant = shift;
            $invocant->$method(@_);
        };
    }
}

1;
