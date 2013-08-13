PG_USER=$1
if [ -n $2 ]; then
  PG_PW="$2"
else
  PG_PW="$1"
fi
read -r -d '' PG_CMD <<HEREDOC0
CREATE USER $PG_USER superuser createdb login;
ALTER USER $PG_USER WITH PASSWORD '$PG_PW';
CREATE DATABASE $PG_USER ;
GRANT ALL ON DATABASE $PG_USER TO $PG_USER;
HEREDOC0
echo $PG_CMD | su -l postgres -c psql
