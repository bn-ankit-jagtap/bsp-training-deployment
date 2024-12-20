#!/bin/sh
set -x 
set -e
# so there are some volumes we have used we will use this dummy script to copy necessory directories to those volumes. 
cp -r /aj/* /code/
chmod -R 777 /code/
cp -r /aj/etc/docker/data/* docker-entrypoint-initdb.d/
chmod -R 777 docker-entrypoint-initdb.d/
cp -r /aj/etc/docker/data/tomcat-data.tar.gz /servers/tomcat/storage/
cd /servers/tomcat/storage/
tar xvzf tomcat-data.tar.gz
cd / 
chmod -R 777 /servers/tomcat/storage/
cp -r /aj/etc/docker/data/solr.tar.gz /var/solr/data/collection1/data/
chmod -R 777 /var/solr/data/collection1/data/
cd /etc/aws/
touch credentials
exit

