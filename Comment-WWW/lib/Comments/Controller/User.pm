package Comments::Controller::User;
use base 'Mojolicious::Controller';
use strict;
use warnings;

sub register {
    my $self = shift;
    $self->respond_to(
        json => sub {
            my $self    = shift;
            my $errors  = $self->validate;
            if ( scalar @$errors == 0 ) {
                if ( ! $self->register_user ) {
                    $self->render( json => { status => "ERROR", errors => [ "There was an error creating your user. Please try again." ] } )
                } else {
                    $self->render( json => { status => "OK"  } )
                }
            } else {
                $self->render( json => {
                    status => "ERROR",
                    errors => $errors,
                } );
            }
        },
    );
}

sub validate {
    my $self    = shift;
    my @errors  = ();
    push @errors, {message => "You must send a username"} if ! $self->tx->req->json->{ username };
    push @errors, {message => "You must send a password field"} if ! $self->tx->req->json->{ password };
    push @errors, {message => "You must send password confirm field"} if ! $self->tx->req->json->{ password_confirm };
    if ( exists $self->tx->req->json->{ password } and exists $self->tx->req->json->{ password_confirm } ) {
        push @errors, { message => "Confirmation password is incorrect" } 
            if $self->tx->req->json->{ password } ne $self->tx->req->json->{ password_confirm } ;
    }
    my $user = $self->db->resultset('Login')->find( { username => $self->tx->req->json->{ username } } );
    push @errors, { message => "Username already exists. Select a new one." } if $user;
    return \@errors;
}

sub register_user {
    my $self = shift;
    my $new_user = $self->db->resultset('Login')->create({
        username => $self->tx->req->json->{ username },
        password => $self->tx->req->json->{ password },
    });
    if ( $new_user ) {
        return 1;
    }
    return 0;
}

sub login {
    my $self = shift;
    $self->respond_to(
        json => sub {
            my $self = shift;
            if ( $self->tx->req->json->{ username } && $self->tx->req->json->{ password } ) {
                my $user = $self->db->resultset('Login')->find({ 
                    password => $self->tx->req->json->{ password },
                    username => $self->tx->req->json->{ username },
                });
                if ( $user ) {
                    $self->session->{ username } = $user->username;
                    $self->session->{ user_id }  = $user->id;
                   #$self->cookie( user_id => $user->id , { expires => time + 84600 });
                   #$self->cookie( username => $user->username , { expires => time + 84600 });
                    $self->render( json => {
                        status => "OK",
                    } );
                } else {
                    $self->render( json => {
                        status  => "ERROR",
                        message => ["incorrect username or password."]
                    } )
                }
            }
        },
        html => sub {
            #render login template
        },
    );
}

#   sub show_user {
#       my $self = shift;
#       use DDP;
#       warn p $self->tx->req->cookies;
#   }

sub set_session {
    my $self = shift;
    if (     $self->req->method ne 'OPTIONS' #skip method OPTIONS because browser sends this as pre-flight
        && ! $self->session->{ user_id } ) {
        $self->create_anon_user;
    }
    return 1;
}

sub create_anon_user {
    my $self = shift;
    my $new_user = $self->db->resultset('Login')->create({});
    $new_user->update({username  => "Anonimo_".$new_user->id});
    $self->session->{ username } = $new_user->username;
    $self->session->{ user_id }  = $new_user->id;
}

1;
