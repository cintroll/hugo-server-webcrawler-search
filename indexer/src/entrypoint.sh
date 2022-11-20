#!/bin/bash

rm server/solr/configsets/nutch/conf/managed-schema

bin/solr start
bin/solr create -c nutch -d server/solr/configsets/nutch/conf/

while true
do
    sleep 100
done