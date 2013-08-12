USER=$1
read -r -d '' INSTALL_CMD <<HEREDOC0
load_rbenv;
rbenv install 1.9.3-p448;
rm ~/.rbenv/versions/ruby-1.9.3;
ln -s  ~/.rbenv/versions/1.9.3-p448/ ~/.rbenv/versions/ruby-1.9.3;
rbenv shell ruby-1.9.3;
rbenv rehash;
gem update --system;
gem install rubygems-update;
rbenv rehash;
update_rubygems;
gem install bundler;
rbenv rehash;
HEREDOC0
echo "$INSTALL_CMD" | su -l $USER 
