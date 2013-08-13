KEY=$1
echo "adding $KEY"
TMPFILE=`mktemp /tmp/debuntu_XXXXX`
if [ ! -d ~/.ssh ]; then
  mkdir -p ~/.ssh
  chmod go-rwx ~/.ssh
fi
if [ ! -f ~/.ssh/authorized_keys ]; then
  touch ~/.ssh/authorized_keys
  chmod go-rwx ~/.ssh/authorized_keys
fi
echo "$KEY" >> ~/.ssh/authorized_keys;
cat ~/.ssh/authorized_keys | sort | uniq > "$TMPFILE"
cat $TMPFILE > ~/.ssh/authorized_keys
echo "the content of ~/.ssh/authorized_keys is now:" 
echo "=============================================" 
cat ~/.ssh/authorized_keys
