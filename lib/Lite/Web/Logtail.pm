package Lite::Web::Logtail;
use strict;
use warnings;
use utf8;
use parent qw/Lite Amon2::Web/;

use File::Basename;

sub hello_world {
    my ($self, $c) = @_;
    return $c->render('hello_world.tx', {});
}

# sub hello_world_text {
#     my ($self, $c) = @_;
#     return 'hello world';
# }

sub cat {
    my ($self, $c) = @_;
    my $log_path = dirname(__FILE__) . '/test.log';

    open(FILE, "< $log_path") or die "$!\n : $log_path";

    my $str = '';
    while(my $line = <FILE>){
        chomp($line);
        $str .= $line . "\n";
    }
    close(FILE);

    return $c->render('cat.tx', { cat => $str });

}

1;