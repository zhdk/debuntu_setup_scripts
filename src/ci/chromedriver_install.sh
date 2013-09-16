TMDIR=`mktemp -d`
cd $TMDIR
MACHINE_BITS=`uname -m | cut -d '_' -f 2`
curl -s -L "https://chromedriver.googlecode.com/files/chromedriver_linux${MACHINE_BITS}_2.3.zip" > chromedriver.zip
unzip chromedriver.zip
mv chromedriver ~/bin
cd
rm -rf $TMDIR
