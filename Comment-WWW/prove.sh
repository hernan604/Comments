export DB_NAME="dbi:Pg:dbname=cmt"
export DB_USER="hernan"
export DB_PASS="hernan"
prove -I../Comment-DB/lib/ -I./lib t
