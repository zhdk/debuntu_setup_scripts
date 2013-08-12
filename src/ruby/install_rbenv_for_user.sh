USER=$1
read -r -d '' INSTALL_CMD <<HEREDOC0
curl https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash;
HEREDOC0
echo "$INSTALL_CMD" | su -l $USER 
