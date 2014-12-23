use Test::More;
use Test::Mojo;
use DDP;
use URI::Escape;
use Mojo::URL;
use lib './t/lib';
use Tests;

my $t = Test::Mojo->new('Comments');
$t->ua->max_redirects(10);
my $tests = Tests->new;

#LOGIN BEFORE COMMENT
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

$r = $t->get_ok( $tests->url_coments_get )
  ->status_is(200)    #tem que redirecionar se receber url na raiz
  ->json_has("/comments")

  #   ->json_is( "/comments", [] )
  ;

# content should bring comments for target url
$r = $t->get_ok( $tests->url_raiz_com_url_para_comentar )
  ->status_is(200)    #tem que redirecionar se receber url na raiz
  ->json_has("/comments")

  #   ->json_is( "/comments", [] )
  ;

#warn p $r->tx->res->content->get_body_chunk;

my $rand         = rand;
my $rand_comment = "Comentario random: " . $rand;
$t->put_ok(
    $tests->url_coments_put => {
        DNT    => 1,
        Accept => 'application/json',
    },
    json => {
        comment => $rand_comment,
    }
)->json_has('/status')->json_is( '/status', 'ok' );

#warn p $r;

$r = $t->get_ok( $tests->url_raiz_com_url_para_comentar )
  ->status_is(200)    #tem que redirecionar se receber url na raiz
  ->json_has("/comments")

  #   ->json_is( "/comments", [] )
  ;

#my $comments = $r->tx->res->json->{ comments };

ok(
    grep { $_->{comment} =~ m#$rand_comment# }
      @{ $r->tx->res->json->{comments} },
    "Encontrou comentario inserido no teste anterior"
);

done_testing;
