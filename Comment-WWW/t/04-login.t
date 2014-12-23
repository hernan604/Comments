use Test::More;
use Test::Mojo;
use DDP;
use URI::Escape;
use Mojo::URL;
use lib './t/lib';
use Tests;

my $t     = Test::Mojo->new("Comments");
$t->ua->max_redirects( 10 );
my $tests = Tests->new;

$t->put_ok(
    $tests->url_login => {
        DNT    => 1,
        Accept => "application/json",
    },
    json => {
        username => $tests->username,
        password => "WONG-PASS",
    }
)->json_has("/status")->json_is( '/status', "ERROR" );

$t->put_ok(
    $tests->url_login => {
        DNT    => 1,
        Accept => "application/json",
    },
    json => {
        username => $tests->username,
        password => $tests->password,
    }
)->json_has("/status")->json_is( '/status', "OK" );

done_testing;
