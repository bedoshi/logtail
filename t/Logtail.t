use strict;
use warnings;
use utf8;
use t::Util;
use Plack::Test;
use Plack::Util;
use Test::More;
use Test::Requires 'Test::WWW::Mechanize::PSGI';
use JSON::XS;

my $app = Plack::Util::load_psgi 'script/lite-server';

my $mech = Test::WWW::Mechanize::PSGI->new(app => $app);

subtest '#cat' => sub {
    $mech->get_ok('/cat');
};

subtest '#get_diff' => sub {
    $mech->get_ok('/tail');
};

subtest '#check_mutipart' => sub {
    my $res = $mech->post('/form',
        Content => [
            param1 => 'test',
            param2 => 'test2',
        ]
    );
    is $mech->status, 200;
};

subtest '#api_check_multipart' => sub {
    subtest 'give only text parameter' => sub {
        my $res = $mech->post('/api/form',
            Content => [
                param1 => 'test',
                param2 => 'test2',
            ]
        );

        my $body = decode_json($res->content);
        is $body->{status}, 200;
        is $body->{param1}, 'test';
        is $body->{param2}, 'test2';
    };

    subtest 'give text and file parameter' => sub {
        my $res = $mech->post('/api/form',
            Content_type => 'multipart/form-data',
            Content => [
                param1 => 'test',
                param2 => 'test2',
                file => ['t/dat/image/image0.jpg'],
            ],
        );

        my $body = decode_json($res->content);
        is $body->{status}, 200;
        is $body->{param1}, 'test';
        is $body->{param2}, 'test2';
        ok $body->{file_path};

        use Data::Dumper;
        print Dumper($body);
    };
};

done_testing;
