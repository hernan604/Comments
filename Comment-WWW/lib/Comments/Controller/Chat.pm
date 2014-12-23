package Comments::Controller::Chat;
use strict;
use warnings;
use base 'Mojolicious::Controller';

my $clients = {};

sub chat_ws {
    my $self = shift;
    $self->inactivity_timeout(300);

    my $id = sprintf "%s", $self->tx;
    $clients->{$id} = $self->tx;

    $self->on(message => sub {
        my ($self, $msg) = @_;

        my $dt   = DateTime->now( time_zone => 'America/Sao_Paulo' );

        for (keys %$clients) {
            $clients->{$_}->send({json => {
                hms  => $dt->hms,
                text => $msg,
            }});
        }
    });

    $self->on(finish => sub {
        delete $clients->{$id};
    });
}


sub iframe_test {
    my $self = shift;
    $self->render( "iframe", format => 'html' )
}


1;
