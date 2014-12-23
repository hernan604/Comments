clear
export DB_NAME="dbi:Pg:dbname=cmt"
export DB_USER="hernan"
export DB_PASS="hernan"
export MOJO_LISTEN="http://*:3000"
export DBIC_TRACE=1
perl -I../Comment-DB/lib/ -I./lib myapp.pl
