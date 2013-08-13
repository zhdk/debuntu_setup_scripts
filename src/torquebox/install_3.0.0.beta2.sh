stop torquebox
killall torquebox
killall -9 torquebox

debuntu_jvm_open_jdk_install

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
