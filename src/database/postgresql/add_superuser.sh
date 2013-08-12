PG_USER=$1
read -r -d '' PG_CMD <<HEREDOC0
CREATE USER $PG_USER superuser createdb login;
CREATE DATABASE $PG_USER ;
GRANT ALL ON DATABASE $PG_USER TO $PG_USER;
HEREDOC0
echo $PG_CMD | su -l postgres -c psql
