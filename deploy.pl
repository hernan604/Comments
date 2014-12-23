use lib './Comment-DB/lib';
use Comment::DB;
my $schema = Comment::DB->connect( $ENV{DB_NAME}, $ENV{DB_USER}, $ENV{DB_PASS} );
$schema->deploy;
