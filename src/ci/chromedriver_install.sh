TMDIR=`mktemp -d`
cd $TMDIR
MACHINE_BITS=`uname -m | cut -d '_' -f 2`
curl "https://chromedriver.googlecode.com/files/chromedriver_linux${MACHINE_BITS}_26.0.1383.0.zip" > chromedriver.zip
unzip chromedriver.zip
mv chromedriver ~/bin
cd
rm -rf $TMDIR
