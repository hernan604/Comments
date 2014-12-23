use strict;
use warnings;
use Mojo::Server::Morbo;
#use Comments;

#my $app = Comments->new;
#$app->start( 'daemon', '-l', 'https://*:3000' );
#$app->start( 'daemon', '-l', 'http://*:3000' );
use Mojo::Server::Morbo;

my $morbo = Mojo::Server::Morbo->new;
$morbo->watch(['./']);
$morbo->run('./script/app');



# json put
# curl -H "Content-Type: application/json" -d '{"username":"xyz","password":"xyz"}' http://localhost:8080/insert-json/
#


# json retrieve
# curl -i     -H "Accept: application/json"    -X GET -d "{aaa:1}"     http://localhost:8080/retrieve-json/
#


