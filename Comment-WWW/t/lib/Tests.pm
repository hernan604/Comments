package Tests;
use Moo;
use Mojo::URL; 
use URI::Escape;

has username       => (
    is      => "rw",
    default => sub {
        "usuario_teste"
} );

has password   => (
    is      => "rw",
    default => sub {
        "senha_teste"
} );

has url_raiz_com_url_para_comentar => (
    is      => "lazy",
    default => sub {
        my $self = shift;
        Mojo::URL->new('/')->query( url => $self->url_escaped );
    }
);

has url_coments_put => (
    is      => "lazy",
    default => sub {
        my $self = shift;
        Mojo::URL->new('/comment/put')->query( url => $self->url_escaped );
    }
);

has url_coments_get => (
    is      => "lazy",
    default => sub {
        my $self = shift;
        Mojo::URL->new('/comment/get')->query( url => $self->url_escaped );
    }
);

has url_escaped => (
    is => "lazy",
    default => sub {
        my $self = shift;
        uri_escape "http://www.site.com?var=y&x=0"
    }
);

has url_login => ( 
    is      => "rw",
    default => sub {
        Mojo::URL->new("/login");
    }
);

sub cleanup_db {
    my $self = shift;
    my $t    = shift;
    $t->app->db->resultset( 'Comment' )->search({})->delete;
    $t->app->db->resultset( 'Url' )->search({})->delete;
    $t->app->db->resultset( 'Login' )->search({})->delete;
}


1;
