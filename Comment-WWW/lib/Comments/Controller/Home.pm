package Comments::Controller::Home;
use strict;
use warnings;
use base 'Mojolicious::Controller';
use DDP;

sub get {
    my $self = shift;
#   if ( ! $self->session->{ user_id } ) {
#       my $new_user = $self->db->resultset('Login')->create({});
#       $new_user->update({username  => "Anonimo_".$new_user->id});
#       $self->session->{ username } = $new_user->username;
#       $self->session->{ user_id }  = $new_user->id;
#   }
    if ( my $comment_url = $self->param( "url" ) ) {
#       $self->redirect_to( 'comment_get' , {  url => $comment_url } );
        $self->redirect_to( $self->url_for("comment_get")->query(url=>$comment_url ) );
    }
    $self->respond_to(
        html => sub {
            my $self = shift;
            #forcou resposta como json
            $self->render( 'index', format => "html" );
        },
        json => sub {
            my $self = shift;
            $self->render( json => { welcome_msg => 'Welcome!' } );
        }
    );
}

1;
