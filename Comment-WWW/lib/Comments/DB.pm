package Comments::DB;
use Moo;

sub write {
    my $self = shift;
    return "my version: " . $self->version;
} 

sub read {
    my $self = shift;
    return "my version: " . $self->version;
}


1;
