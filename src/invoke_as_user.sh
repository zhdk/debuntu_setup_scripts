TEMPFILE=`mktemp /tmp/debuntu_fun_XXXXXX`
chmod a+rx $TEMPFILE
debuntu_meta_write_functions_for_sourcing $TEMPFILE
cat <<HEREDOC0 | su -l $1
source $TEMPFILE
$2 '$3' '$4' 
HEREDOC0
rm -f $TEMPFILE
