#!/bin/bash
if [ "`which apt-get`" != "" ]; then
  apt-get update
  apt-get install git -y
elif [ "`which yum`" != ""  ]; then
  yum install git -y
else
  echo "The application apt-get or yum doesn't exist. Please check your OS."
  exit 1
fi

git clone http://github.com/nii-cloud/dodai-deploy

cd dodai-deploy/setup-env
./setup.sh -x "$http_proxy" server
./setup.sh -s `hostname -f` -x "$http_proxy" node
./setup-storage-for-swift.sh loopback /srv/node sdb1 4

cd ..
script/start-servers production
