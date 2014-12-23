use Test::More;
use Test::Mojo;
use DDP;
use URI::Escape;
use Mojo::URL; 
use lib './t/lib';
use Tests;

my $t     = Test::Mojo->new( 'Comments' );
$t->ua->max_redirects( 10 );
my $tests = Tests->new;

my $r = $t->get_ok( $tests->url_raiz_com_url_para_comentar )
    ->status_is( 200 ) 
    ->json_has( "/comments" )
#   ->json_is( "/comments", [] )
    ;

$t->put_ok(
    $tests->url_coments_put => {
        DNT => 1 
    }, 
    json => {
        comment => "Primeiro comentario na pagina",
    }
)
->json_has('/status')
->json_is('/status', 'ok');

my $r = $t->get_ok( $tests->url_raiz_com_url_para_comentar )
    ->status_is( 200 ) 
    ->json_has( "/comments" )
#   ->json_is( "/comments", [] )
    ;


#abre url PUT de comentario mas nao enviaum comentario... entao da erro e nao traz o array de comments
my $r = $t->get_ok( $tests->url_coments_put )
    ->status_is( 200 ) 
    ->json_has( "/status" )
    ->json_is( "/status", "ERROR" )
    ->json_hasnt( "/comments" )
    ;

done_testing;
