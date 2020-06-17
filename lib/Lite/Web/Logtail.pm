package Lite::Web::Logtail;
use strict;
use warnings;
use utf8;
use parent qw/Lite Amon2::Web/;

use File::Basename;
use File::Copy qw/copy/;

sub hello_world {
    my ($self, $c) = @_;
    return $c->render('hello_world.tx', {});
}

sub cat {
    my ($self, $c) = @_;

    my $log_dir = dirname(__FILE__);
    my $log_path = $log_dir . '/test.log';
    my $log_backup = $log_dir . '/backup.log';

    copy($log_path, $log_backup) or die "$!";
    open(FILE, "< $log_path") or die "$!\n : $log_path";

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

    my $log_dir = dirname(__FILE__);
    my $log_path = $log_dir . '/test.log';
    my $log_backup = $log_dir . '/backup.log';

    open(FILE_BAC, "< $log_backup") or die "$!: $log_backup";
    my $backup_line_num = 0;
    my $diff_str = '';
    while (<FILE_BAC>) {
        $backup_line_num++;
    }
    close(FILE_BAC);

    open(FILE_ORG, "< $log_path") or die "$!: $log_path";
    my $org_line_num = 0;
    while(my $line = <FILE_ORG>) {
        $org_line_num++;
        if ($org_line_num > $backup_line_num) {
            chomp($line);
            $diff_str .= $line . "\n";
        }
    }
    close(FILE_ORG);

    copy($log_path, $log_backup);

    return $c->render_json({
        diff => $diff_str,
        lines => $org_line_num - $backup_line_num,
    });
}

## multipart/form-data post からパラメータを取得したいだけのTrial code
sub check_mutipart {
    my ($self, $c) = @_;

    my $param1      = $c->req->param('param1');
    my $param2      = $c->req->param('param2');
    my $file_path   = $c->req->uploads->{'file'}->{'tempname'}; #temp file path

    return $c->render('form.tx', { param1 => $param1, param2 => $param2, file_path => $file_path});
}

1;