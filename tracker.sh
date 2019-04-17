#!/bin/bash

echo "start trackerd"
/etc/init.d/fdfs_trackerd start

tail -f  /dev/null