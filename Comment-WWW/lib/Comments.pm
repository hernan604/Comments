package Comments;
use strict;
use warnings;
use Mojo::Base 'Mojolicious';
use Mojolicious::Plugin::Authentication;

# This method will run once at server start
sub startup {
    my $self = shift;

    my $config = $self->plugin( 'Config' => { file => 'myconfig.pl' } );
    $self->load_plugins;
    $self->load_config;
    $self->load_routes;

    # Router
    my $r = $self->routes;
    $r->namespaces(['Comments::Controller']);
    $self->helper( db => sub { $config->{ db } } );

    $self->sessions->cookie_name( 'app_comments' );
    $self->sessions->default_expiration( 24*60*60*52 );#1year

#   my $user = $self->db->resultset('Login')->create( { username => "admin", password => "admin" } );
    
#   Ativa CORS globalmente
    $self->hook(
        before_dispatch => sub {
          my $c = shift;
#         $c->res->headers->header('Access-Control-Allow-Origin'      => '*');
#         $c->res->headers->header('Access-Control-Allow-Origin'      => 'http://esporte.uol.com.br');
          my %headers = %{ $c->req->headers };
          my $origin  =
              ( %headers && 
                $headers{headers} && 
                exists $headers{headers}->{origin} && 
                ref    $headers{headers}->{origin} eq ref [] &&
                scalar @{$headers{headers}->{origin}} > 0
              )
              ? $headers{headers}->{origin}->[0]
              : '*'
              ;
          $c->res->headers->header('Access-Control-Allow-Origin'      => $origin );
          $c->res->headers->header('Access-Control-Allow-Methods'     => 'GET, POST, PUT, DELETE');
          $c->res->headers->header('Access-Control-Allow-Credentials' => 'true');
          $c->res->headers->header('Access-Control-Allow-Headers'     => 'X-Requested-With, accept, content-type, set-cookie');
         #$c->res->headers->header('Access-Control-Request-Headers'   => 'X-Requested-With, accept, content-type, set-cookie');
        }
    );
    
    # Route
#   $r->route('/welcome')->to(controller => 'Foo', action => 'welcome');
#   $r->route('/insert-json')->to(controller => 'MyRest', action => 'insert');
#   $r->route('/retrieve-json')->to(controller => 'MyRest', action => 'retrieve');

    my $bridge = $r->bridge('/')->to('user#set_session');

    $bridge->route('/')
        ->name('home')
        ->to(controller => 'Home', action => 'get');

    $bridge->route('/comment/get/')
        ->name('comment_get')
        ->to(controller => 'Comment', action => 'get_by_url');

    $bridge->route('/comment/put/')
        ->name('comment_put')
        ->to(controller => 'Comment', action => 'put_by_url');

    $bridge->route('/register/')
        ->name('register')
        ->to(controller => 'User', action => 'register');

    $bridge->route('/login/')
        ->name('login')
        ->to(controller => 'User', action => 'login');


    $bridge->websocket('/chat') #NOT WORKING YET.... 
        ->name('chat')
        ->to(controller => 'Chat', action => 'chat_ws');

    $bridge->route('/iframe') #NOT WORKING YET.... 
        ->name('chat')
        ->to(controller => 'Chat', action => 'iframe_test');

#   $self->secret('SomethingVerySecret');
#   $self->mode('development');

#   my $config = $self->plugin( 'JSONConfig' => { file=>'config.json' } );

}

sub load_plugins {
    my $self = shift;
    $self->plugin('authentication' => $self->config->{ auth } );
}

sub load_config {
    my $app = shift;
}

sub load_routes {
    my $app = shift;
}


1;
