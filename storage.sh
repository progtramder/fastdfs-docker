#!/bin/bash

tracker=$FASTDFS_TRACKER
tracker_fake="com.ikingtech.ch116221"
group=$FASTDFS_GROUP
group_fake="groupx"

sed -i "s/$tracker_fake/$tracker/g" /etc/fdfs/client.conf
sed -i "s/$tracker_fake/$tracker/g" /etc/fdfs/storage.conf
sed -i "s/$tracker_fake/$tracker/g" /etc/fdfs/mod_fastdfs.conf
sed -i "s/$group_fake/$group/g" /etc/fdfs/storage.conf
sed -i "s/$group_fake/$group/g" /etc/fdfs/mod_fastdfs.conf

cp /etc/fdfs/nginx.conf /usr/local/nginx/conf

echo "start storage"
/etc/init.d/fdfs_storaged start

echo "start nginx"
/usr/local/nginx/sbin/nginx 

tail -f  /dev/null