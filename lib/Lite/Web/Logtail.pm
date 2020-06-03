package Lite::Web::Logtail;
use strict;
use warnings;
use utf8;
use parent qw/Lite Amon2::Web/;

sub hello_world {
    my ($self, $c) = @_;
    return $c->render('hello_world.tx', {});
}

sub hello_world_text {
    my ($self, $c) = @_;
    return 'hello world';
}

sub cat {
    my $log_path = '../../static/test.log';

}

1;