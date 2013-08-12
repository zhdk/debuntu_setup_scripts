USER=$1
read -r -d '' INSTALL_CMD <<HEREDOC0
mkdir -p ~/bin;
curl https://raw.github.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein;
chmod a+x ~/bin/lein;
HEREDOC0
echo $INSTALL_CMD | su -l $USER 
