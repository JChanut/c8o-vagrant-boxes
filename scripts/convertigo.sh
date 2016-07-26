#!/bin/bash
C8O_INSTALL=convertigo-server-7.4.0-v41819-linux32.run
C8O_PATH=/moteurs/convertigo
C8O_HOME=/applis/convertigo
C8O_USER=convertigoMobilityPlatform
C8O_INIT=/etc/init.d/convertigoMobilityPlatform
C8O_WEBAPP=$C8O_PATH/tomcat/webapps/convertigo

echo 'Installing Convertigo Dependencies for Ubuntu 14.04'

apt-get install -y lib32z1 libgtk2.0-0 libstdc++6:i386 libxft2:i386 libxt6:i386 libxtst6:i386

echo 'Downloading Convertigo installation package 7.4'
wget -q http://10.105.132.141:8080/docs-caasm/$C8O_INSTALL.zip

echo 'Installing Convertigo'
unzip $C8O_INSTALL.zip

chmod +x $C8O_INSTALL

./$C8O_INSTALL -- --accept-license --default-user --path $C8O_PATH --rc-create --no-start

echo 'Moving Convertigo home folder'
#mkdir /applis/convertigo
mv /home/$C8O_USER/convertigo $C8O_HOME
sed -i "s~/home/$C8O_USER/convertigo~$C8O_HOME~g" $C8O_INIT

echo 'Adding cors filter configuration for Tomcat'
cp -r /tmp/floppy/simple-cors-filter.jar $C8O_WEBAPP/WEB-INF/lib/simple-cors-filter.jar
chown $C8O_USER:$C8O_USER $C8O_WEBAPP/WEB-INF/lib/simple-cors-filter.jar

cat $C8O_WEBAPP/WEB-INF/web.xml | grep -v "</web-app>" > new_web_$$.xml
cat /tmp/floppy/cors_filter.part >> new_web_$$.xml
rm $C8O_WEBAPP/WEB-INF/web.xml
cp -r new_web_$$.xml $C8O_WEBAPP/WEB-INF/web.xml

echo 'Adding ddsim Convertigo licences'
rm $C8O_HOME/minime/Java/keys.txt
cp -r /tmp/floppy/keys.txt $C8O_HOME/minime/Java/keys.txt
chown $C8O_USER:$C8O_USER $C8O_HOME/minime/Java/keys.txt

#Cleaning temp file
rm $C8O_INSTALL.zip $C8O_INSTALL new_web_$$.xml

echo 'Starting Convertigo'
$C8O_INIT start