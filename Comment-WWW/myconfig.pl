use Comment::DB;  
my $schema = Comment::DB->connect( $ENV{DB_NAME}, $ENV{DB_USER},  $ENV{DB_PASS});
{
    db => $schema,
    auth => {
        'autoload_user'     => 1,
        'session_key'       => 'some-private-key',
        'load_user'         => sub { 
            my ( $app, $uid ) = @_;
            warn "select where user = ". $uid;
        },
        'validate_user'     => sub {
            my ($app, $username, $password, $extradata) = @_;
            warn "loooking for user: USER: $username -  PASS: $password";
        },
        'current_user_fn'   => 'user', # compatibility with old code
    },
}

