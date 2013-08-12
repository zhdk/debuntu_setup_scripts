function debuntu_database_postgresql_add_superuser {
PG_USER=$1
read -r -d '' PG_CMD <<HEREDOC0
CREATE USER $PG_USER superuser createdb login;
CREATE DATABASE $PG_USER ;
GRANT ALL ON DATABASE $PG_USER TO $PG_USER;
HEREDOC0
echo $PG_CMD | su -l postgres -c psql
}

function debuntu_database_postgresql_install {
apt-get install --assume-yes  postgresql postgresql-client libpq-dev postgresql-contrib
/etc/init.d/postgresql restart
}

function debuntu_jvm_install_jdk {
apt-get install --asume-yes openjdk-7-jre-headless openjdk-7-jdk visualvm
}

function debuntu_jvm_install_leiningen_for_user {
USER=$1
read -r -d '' INSTALL_CMD <<HEREDOC0
mkdir -p ~/bin;
curl https://raw.github.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein;
chmod a+x ~/bin/lein;
HEREDOC0
echo $INSTALL_CMD | su -l $USER 
}

function debuntu_ruby_install_rbenv_for_user {
USER=$1
read -r -d '' INSTALL_CMD <<HEREDOC0
curl https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash;
HEREDOC0
echo "$INSTALL_CMD" | su -l $USER 
}

function debuntu_ruby_install_ruby_1.9.3_for_user {
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
}

function debuntu_ruby_install_ruby_2.0.0_for_user {
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
}

function debuntu_ruby_install_system_dependencies {
apt-get install --assume-yes git zlib1g-dev \
  libssl-dev libxslt1-dev libxml2-dev build-essential \
  libreadline-dev libreadline6 libreadline6-dev g++
}

function debuntu_ruby_setup_rbenv_loader {
cat <<'HEREDOC0' > /etc/profile.d/rbenv.sh
function load_rbenv {
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"
}
function unload_rbenv(){
export PATH=`ruby -e "puts ENV['PATH'].split(':').reject{|s| s.match(/\.rbenv/)}.join(':')"`
}
HEREDOC0
}

function debuntu_ssh_download_and_add_to_authorized_keys_for_user {
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
}

function debuntu_system_apt_upgrade {
apg-get update
apt-get dist-upgrade --assume-yes
}

function debuntu_system_install_basics {
apt-get install --assume-yes curl git openssh-server unzip zip
}

function debuntu_system_set_us-utf8_locale {
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
apt-get install --assume-yes locales
dpkg-reconfigure locales

cat <<HEREDOC0 > /etc/profile.d/locale.sh 
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
HEREDOC0
}

function debuntu_system_setup_vim {
apt-get install --assume-yes vim-nox
update-alternatives --set editor /usr/bin/vim.nox
}

function debuntu_torquebox_install_3.0.0.beta2 {
stop torquebox
killall torquebox
killall -9 torquebox

debuntu_jvm_install_jdk

TB_URL="http://d2t70pdxfgqbmq.cloudfront.net/release/org/torquebox/torquebox-dist/3.0.0.beta2/torquebox-dist-3.0.0.beta2-bin.zip"
TB_VERSION="3.0.0.beta2"
TB_ROOT="/opt/torquebox-3.0.0.beta2"


TMP_FILE="/tmp/torquebox-${TB_VERSION}.zip"
TB_LINK="/opt/torquebox"

adduser --disabled-password -gecos "" torquebox
if [ ! -f ${TMP_FILE} ]; then
  curl "$TB_URL" > "$TMP_FILE"
fi
rm -rf ${TB_ROOT}
unzip "$TMP_FILE" -d /opt
chown -R torquebox "${TB_ROOT}"
rm -f ${TB_LINK}
ln -s ${TB_ROOT} ${TB_LINK}

debuntu_torquebox_setup_env_loader
debuntu_torquebox_setup_logrotate
debuntu_torquebox_setup_upstart

start torquebox
}

function debuntu_torquebox_setup_env_loader {
cat <<'HEREDOC0' > /etc/profile.d/torquebox.sh
function load_torquebox_env {
export JRUBY_OPTS="--1.9"
export JAVA_OPTS="-server -Xms64m -Xmx2G -XX:MaxPermSize=512m"
export JAVA_OPTS="$JAVA_OPTS -Djava.net.preferIPv4Stack=true -Dorg.jboss.resolver.warning=true"
export JAVA_OPTS="$JAVA_OPTS -Dsun.rmi.dgc.client.gcInterval=3600000 -Dsun.rmi.dgc.server.gcInterval=3600000"
export JAVA_OPTS="$JAVA_OPTS -Djboss.modules.system.pkgs=$JBOSS_MODULES_SYSTEM_PKGS -Djava.awt.headless=true"
export JAVA_OPTS="$JAVA_OPTS -Djboss.server.default.config=standalone.xml"
export TORQUEBOX_HOME=/opt/torquebox
export JBOSS_HOME=${TORQUEBOX_HOME}/jboss
export JRUBY_HOME=${TORQUEBOX_HOME}/jruby
export PATH=${TORQUEBOX_HOME}/bin:${JBOSS_HOME}/bin:${JRUBY_HOME}/bin:${PATH}
}
HEREDOC0


}

function debuntu_torquebox_setup_logrotate {
cat <<'HEREDOC0' > /etc/logrotate.d/torquebox
/var/log/torquebox/*.log  /opt/torquebox/jboss/standalone/log/*/*.log /home/torquebox/*/log/*.log {
daily
missingok
size 1M
rotate 21
compress
delaycompress
notifempty
copytruncate
}
HEREDOC0
logrotate -d -v /etc/logrotate.d/torquebox
}

function debuntu_torquebox_setup_upstart {
cat <<'HEREDOC0' > /etc/init/torquebox.conf
description "This is an upstart job file for TorqueBox"

pre-start script
bash << "EOF"
  mkdir -p /var/log/torquebox
  chown -R torquebox /var/log/torquebox
EOF
end script

start on filesystem and net-device-up IFACE!=eth0
stop on stopped network-services
respawn
limit nofile 4096 4096

script
bash << "EOF"
  su - torquebox
  load_torquebox_env
  /opt/torquebox/jboss/bin/standalone.sh >> /var/log/torquebox/torquebox.log 2>&1
EOF
end script
HEREDOC0
}

