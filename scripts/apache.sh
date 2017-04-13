#!/bin/bash

SERVICE_USER_GROUP=vagrant:vagrant

# runtime environment
mkdir -p /apps/aspace/apache/{bin,logs,run}
chown -R "$SERVICE_USER_GROUP" /apps/aspace/apache

# symlink to system modules
ln -sf /usr/lib64/httpd/modules /apps/aspace/apache/modules

# compile the helper setuid program
cd /apps/aspace/apache/src
make SERVICE_USER=vagrant SERVICE_GROUP=vagrant install clean
