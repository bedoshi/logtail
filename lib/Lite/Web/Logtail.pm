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
    my $log_dir = dirname(__FILE__);
    my $log_path = $log_dir . '/test.log';
    my $log_backup = $log_dir . '/backup.log';

    open(FILE, "< $log_path") or die "$!\n : $log_path";
    open(FILE, "> $log_backup") or die "$!\n : $log_backup";

    my $str = '';
    while(my $line = <FILE>){
        chomp($line);
        $str .= $line . "\n";
    }
    close(FILE);

    return $c->render('cat.tx', { cat => $str });

}

1;