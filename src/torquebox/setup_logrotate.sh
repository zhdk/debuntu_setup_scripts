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
