package Lite::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

use Lite::Web::Logtail;

any '/' => sub {
    my ($c) = @_;
    my $counter = $c->session->get('counter') || 0;
    $counter++;
    $c->session->set('counter' => $counter);
    return $c->render('index.tx', {
        counter => $counter,
    });
};

any '/hello_world' => 'Lite::Web::Logtail#hello_world';
## failed displaying string by controller returning only that.
# any '/hello_world_text' => 'Lite::Web::Logtail#hello_world_text';

any '/cat' => 'Lite::Web::Logtail#cat';
any '/tail' => 'Lite::Web::Logtail#get_diff';
any '/form' => 'Lite::Web::Logtail#check_mutipart';

any '/form' => 'Lite::Web::Logtail#form_test';
post '/reset_counter' => sub {
    my $c = shift;
    $c->session->remove('counter');
    return $c->redirect('/');
};

post '/account/logout' => sub {
    my ($c) = @_;
    $c->session->expire();
    return $c->redirect('/');
};



1;
