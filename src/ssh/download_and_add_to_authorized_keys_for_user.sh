# download and adds a ssh-key to authorized key of an existing user 
# first argument is the user, second argument is the url 
USER=$1
URL=$2
TMPFILE=`mktemp`
chown $USER $TMPFILE
read -r -d '' INSTALL_CMD <<HEREDOC0
if [ ! -d ~/.ssh ]; then
  mkdir -p ~/.ssh
  chmod go-rwx ~/.ssh
fi
if [ ! -f ~/.ssh/authorized_keys ]; then
  touch ~/.ssh/authorized_keys
  chmod go-rwx ~/.ssh/authorized_keys
fi
curl -s "${URL}" >> ~/.ssh/authorized_keys;
cat ~/.ssh/authorized_keys | sort | uniq > $TMPFILE
cat $TMPFILE > ~/.ssh/authorized_keys
rm $TMPFILE
HEREDOC0
echo "$INSTALL_CMD" | su -l $USER
rm $TMPFILE
