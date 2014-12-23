package Comments::Controller::Comment;
use strict;
use warnings;
use base 'Mojolicious::Controller';
use DDP;
use URI::Escape;
use DateTime;

=head2

insere comentario em uma url

=cut

sub put_by_url {
    my $self    = shift;
    my $url     = uri_unescape $self->param( "url" ); #todo add try catch here
    my $db_url   = $self->get_url( $url );

    if ( ! $self->req->json ) {
        return $self->render( json => { status => "ERROR" } );
    }
    if ( ! $self->req->json->{ comment } ) {
        return $self->render( json => { status => "ERROR", message => [ "Missing comment" ] } );
    }

    my $comment = {
        comment     => $self->req->json->{ comment },
        login_id    => $self->session->{ user_id },
        created     => DateTime->now(),
    };
    my $url_cmt = $db_url->create_related( "comments", $comment );
    my $res     = {
        status => ( $url_cmt ) ? "ok" : "fail",
    };
    $self->render( json => $res );
}



=head2

traz comentarios de uma url

=cut

sub get_by_url {
    my $self = shift;
    my $url      = uri_unescape $self->tx->req->param('url'); #todo add try catch here
    my $db_url   = $self->get_url( $url );
    my $comments = [map { { 
        id => $_->id, 
        login_id => $_->login_id, 
        comment_id => $_->comment_id, 
        comment=> $_->comment, 
        url_id => $_->url_id 
    } } $db_url->comments({},{order_by => { -asc => ['id', 'comment_id'] } })->all];
    my $res = {
        url         => $url,
        comments    => $comments,
    };
    $self->render( json => $res );
}

sub get_url {
    my $self = shift;
    my $url = shift;
    my $db_url  = $self->db->resultset('Url')->find( { url => $url } );
    if ( ! $db_url ) {
        $db_url = $self->db->resultset('Url')->create( { url => $url } );
    }
    return $db_url;
}



1;
