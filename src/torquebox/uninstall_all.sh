# this will uninstall all torquebox instances
# but it will leave the torquebox user account
stop torquebox
killall torquebox
killall -9 torquebox
rm -rf /opt/torquebox*
rm -f /etc/init/torquebox.conf
