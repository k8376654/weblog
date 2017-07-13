#!/bin/bash

cd /hadoop/weblog/log;
FILES=$(find $dir -not -empty|sed -e '1,1d')

for f in $FILES
do
  mv $f -f /hadoop/weblog/hadoop-log
done

cd /hadoop/weblog/hadoop-log
FILES=$(find $dir -not -empty|sed -e '1,1d')
for i in $FILES
do
	mdate=$(echo $i | cut -c3-10)
	sdate=$(echo $i | cut -c11-12)
	hadoop fs -mkdir -p /user/hive/prestage/weblog/$mdate/$sdate
	hadoop fs -copyFromLocal -f $i /user/hive/prestage/weblog/$mdate/$sdate
done

hadoop fs -mkdir -p /user/hive/prestage/weblog
echo '' | hadoop fs -put -f - /user/hive/prestage/weblog/test.csv
