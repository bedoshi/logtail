package Lite::Web::Logtail;
use strict;
use warnings;
use utf8;
use parent qw/Lite Amon2::Web/;

use File::Basename;

my $log_dir = dirname(__FILE__);

sub hello_world {
    my ($self, $c) = @_;
    return $c->render('hello_world.tx', {});
}

sub cat {
    my ($self, $c) = @_;

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

sub get_diff {
    my ($self, $c) = @_;

    my $log_path = $log_dir . '/test.log';
    my $log_backup = $log_dir . '/backup.log';

    open(FILE_ORG, "< $log_path") or die "$!: $log_path";
    my $org_line_num = 0;
    while(<FILE_ORG>) {
        $org_line_num++;
    }
    close(FILE_ORG);

    open(FILE_BAC, "< $log_backup") or die "$!: $log_backup";
    my $backup_line_num = 0;
    my $diff_str;
    while (my $line = <FILE_BAC>) {
        $backup_line_num++;
        if ($backup_line_num > $org_line_num) {
            chomp($line);
            $diff_str .= $line . "\n";
        }
    }
    close(FILE_BAC);

    return $c->render_json({
        diff => $diff_str,
    });
}
1;