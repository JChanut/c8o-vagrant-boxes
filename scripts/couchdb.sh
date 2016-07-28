#!/usr/bin/env bash
CDB_USER=couchdb
CDB_CONFIG=/etc/couchdb/local.ini
CDB_DATA=/data01/couchdb
CDB_LOG=/logs/couchdb

echo
echo 'Installing CouchDB Dependencies for Ubuntu'
apt-get install -y erlang-dev erlang-manpages erlang-base-hipe erlang-eunit erlang-nox erlang-xmerl erlang-inets
apt-get install -y libmozjs185-dev libicu-dev libcurl4-gnutls-dev libtool libcurl3

#Testing Ubuntu major version for installing the rights couchdb binaries
major_version="`lsb_release -r | awk '{print $2}' | awk -F. '{print $1}'`";

if [ ! -z "$major_version" -a "$major_version" -eq 12 ]; then
    cdb_common_package=couchdb-common_1.6.1-0ubuntu1_all.deb
	cdb_bin_package=couchdb-bin_1.6.1-0ubuntu1_amd64.deb
	cdb_package=couchdb_1.6.1-0ubuntu1_all.deb
else
    cdb_common_package=couchdb-common_1.6.1-0ubuntu5_all.deb
	cdb_bin_package=couchdb-bin_1.6.1-0ubuntu5_amd64.deb
	cdb_package=couchdb_1.6.1-0ubuntu5_all.deb
fi

echo
echo 'Downloading couchdb packages'
wget -q https://launchpad.net/~couchdb/+archive/ubuntu/stable/+files/$cdb_common_package
wget -q https://launchpad.net/~couchdb/+archive/ubuntu/stable/+files/$cdb_bin_package
wget -q https://launchpad.net/~couchdb/+archive/ubuntu/stable/+files//$cdb_package

echo
echo 'Installing CouchDB'
dpkg -i $cdb_common_package
dpkg -i $cdb_bin_package
dpkg -i $cdb_package

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