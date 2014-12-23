use Test::More;
use Test::Mojo;
use DDP;
use URI::Escape;
use Mojo::URL;
use lib './t/lib';
use Tests;

my $tests = Tests->new;
my $t     = Test::Mojo->new("Comments");
$t->ua->max_redirects( 10 );

my $url_register = Mojo::URL->new("/register");

$t->put_ok(
    $url_register => {
        DNT    => 1,
        Accept => "application/json",
    },
    json => {

        #   username         => $username, #OMMIT USERNAME
        password         => $tests->password,
        password_confirm => $tests->password,
    }
)->json_has('/status')->json_is( '/status', 'ERROR' );

$t->put_ok(
    $url_register => {
        DNT    => 1,
        Accept => "application/json",
    },
    json => {
        username         => $tests->username,
        password         => $tests->password,
        password_confirm => $tests->password,
    }
)->json_has('/status')->json_is( '/status', 'OK' );

#try to register same user again... MUST FAIL.
$t->put_ok(
    $url_register => {
        DNT    => 1,
        Accept => "application/json",
    },
    json => {
        username         => $tests->username,
        password         => $tests->password,
        password_confirm => $tests->password,
    }
)->json_has('/status')->json_is( '/status', 'ERROR' );

#try to register without password_confirm... MUST FAIL.
$t->put_ok(
    $url_register => {
        DNT    => 1,
        Accept => "application/json",
    },
    json => {
        username => $tests->username,
        password => $tests->password,

        #   password_confirm => $tests->password,
    }
)->json_has("/status")->json_is( '/status', "ERROR" );

done_testing;
