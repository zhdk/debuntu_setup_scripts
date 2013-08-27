RUBY=$1

source /etc/profile.d/rbenv.sh
load_rbenv;
rbenv install -f $RUBY;
rbenv shell $RUBY;
rbenv rehash;
gem update --system;
gem install rubygems-update;
update_rubygems;
gem install bundler;
rbenv rehash;

if [ -n "$2" ]; then 
  LINK=$2
  rm -f ~/.rbenv/versions/$LINK;
  ln -s  ~/.rbenv/versions/$RUBY/ ~/.rbenv/versions/$LINK;
fi
