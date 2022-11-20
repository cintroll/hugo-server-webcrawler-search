#!/bin/bash

bin/nutch inject crawl/crawldb urls

bin/nutch generate crawl/crawldb crawl/segments 
s1=`ls -d crawl/segments/2* | tail -1`

bin/nutch fetch $s1
bin/nutch parse $s1
bin/nutch updatedb crawl/crawldb $s1

function updatedb {
    bin/nutch generate crawl/crawldb crawl/segments -topN 1000
    local s2=`ls -d crawl/segments/2* | tail -1`

    bin/nutch fetch $s2
    bin/nutch parse $s2
    bin/nutch updatedb crawl/crawldb $s2
}

updatedb
updatedb

while true
do
    sleep 100
    # updatedb
done