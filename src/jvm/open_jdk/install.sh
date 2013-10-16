apt-get install --assume-yes openjdk-7-jre-headless openjdk-7-jdk

# Ugly hack: visualvm is packaged for Debian testing (jessie), not for wheezy, so
# let's not attempt to install there.
if [ "$(lsb_release -is)" = "Ubuntu" ]; then
        apt-get install --assume-yes visualvm
fi
