use Test::More;
use Test::Mojo;
use DDP;
use URI::Escape;
use Mojo::URL;
use lib './t/lib';
use Tests;

my $t     = Test::Mojo->new('Comments');
my $tests = Tests->new;
$tests->cleanup_db($t);

#raiz recebendo ?url=XXX on query string redirect user to comments page
my $rr = $t->get_ok( $tests->url_raiz_com_url_para_comentar )
  ->status_is(302)    #tem que redirecionar se receber url na raiz
  ;
$t->ua->max_redirects(10);    #permits test useragent to follow redirects

# content should bring comments for target url
my $r = $t->get_ok( $tests->url_raiz_com_url_para_comentar )
  ->status_is(200)            #tem que redirecionar se receber url na raiz
  ->json_has("/comments")

  #   ->json_is( "/comments", [] )
  ;

warn p $r->tx->res->json;

$t->put_ok(
    $tests->url_coments_put => {
        DNT => 1
    },
    json => {
        comment => "Primeiro comentario na pagina",
    }
)->json_has('/status')->json_is( '/status', 'ok' );

my $r = $t->get_ok( $tests->url_raiz_com_url_para_comentar )
  ->status_is(200)    #tem que redirecionar se receber url na raiz
  ->json_has("/comments")

  #   ->json_is( "/comments", [] )
  ;

#   # JSON
#   $t->post_ok('/search.json' => form => {q => 'Perl'})
#     ->status_is(200)
#     ->header_is('Server' => 'Mojolicious (Perl)')
#     ->header_isnt('X-Bender' => 'Bite my shiny metal ass!')
#     ->json_is('/results/4/title' => 'Perl rocks!');

#   # WebSocket
#   $t->websocket_ok('/echo')
#     ->send_ok('hello')
#     ->message_ok
#     ->message_is('echo: hello')
#     ->finish_ok;

done_testing();
