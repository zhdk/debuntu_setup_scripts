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
