#!/bin/bash

bin/nutch inject crawl/crawldb urls

bin/nutch generate crawl/crawldb crawl/segments 
s1=`ls -d crawl/segments/2* | tail -1`

bin/nutch fetch $s1
bin/nutch parse $s1
bin/nutch updatedb crawl/crawldb $s1

bin/nutch generate crawl/crawldb crawl/segments -topN 1000
s2=`ls -d crawl/segments/2* | tail -1`

bin/nutch fetch $s2
bin/nutch parse $s2
bin/nutch updatedb crawl/crawldb $s2

bin/nutch generate crawl/crawldb crawl/segments -topN 1000
s3=`ls -d crawl/segments/2* | tail -1`
echo $s3

bin/nutch fetch $s3
bin/nutch parse $s3
bin/nutch updatedb crawl/crawldb $s3

bin/nutch invertlinks crawl/linkdb -dir crawl/segments

while true
do
    sleep 1
done