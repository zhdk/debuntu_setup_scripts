USER=$1
read -r -d '' INSTALL_CMD <<HEREDOC0
load_rbenv;
rbenv install 2.0.0-p247;
rm ~/.rbenv/versions/ruby-2.0.0;
ln -s  ~/.rbenv/versions/2.0.0-p247/ ~/.rbenv/versions/ruby-2.0.0;
rbenv shell 2.0.0-p247;
rbenv rehash;
gem update --system;
gem install rubygems-update;
rbenv rehash;
update_rubygems;
gem install bundler;
rbenv rehash;
HEREDOC0
echo "$INSTALL_CMD" | su -l $USER 
