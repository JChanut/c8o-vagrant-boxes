#!/usr/bin/env bash
CDB_USER=couchdb
CDB_CONFIG=/etc/couchdb/local.ini
CDB_DATA=/data01/couchdb
CDB_LOG=/logs/couchdb

echo
echo 'Installing CouchDB Dependencies for Ubuntu 14.04'
apt-get install -y erlang-dev erlang-manpages erlang-base-hipe erlang-eunit erlang-nox erlang-xmerl erlang-inets
apt-get install -y libmozjs185-dev libicu-dev libcurl4-gnutls-dev libtool libcurl3

echo
echo 'Downloading couchdb packages'
wget -q http://10.105.132.141:8080/docs-caasm/couchdb/couchdb-common_1.6.1-0ubuntu5_all.deb
wget -q http://10.105.132.141:8080/docs-caasm/couchdb/couchdb-bin_1.6.1-0ubuntu5_amd64.deb
wget -q http://10.105.132.141:8080/docs-caasm/couchdb/couchdb_1.6.1-0ubuntu5_all.deb

echo
echo 'Installing CouchDB'
dpkg -i couchdb-common_1.6.1-0ubuntu5_all.deb
dpkg -i couchdb-bin_1.6.1-0ubuntu5_amd64.deb
dpkg -i couchdb_1.6.1-0ubuntu5_all.deb

echo
echo 'Configuring CouchDB'
if [ ! -d "$CDB_DATA" ]; then
	mkdir $CDB_DATA
fi
chown $CDB_USER:$CDB_USER $CDB_DATA
if [ ! -d "$CDB_LOG" ]; then
	mkdir $CDB_LOG
fi
chown $CDB_USER:$CDB_USER $CDB_LOG
sed -i '/\[couchdb\]/a database_dir = /data01/couchdb' $CDB_CONFIG
sed -i '/\[httpd\]/a bind_address = 0.0.0.0' $CDB_CONFIG
sed -i '/\[log\]/a file = /logs/couchdb/couch.log' $CDB_CONFIG

echo
echo 'Restarting CouchDB'
service couchdb restart

echo
echo 'Removing var log folder and packages'
rm -R /var/log/couchdb/
rm -f *.deb