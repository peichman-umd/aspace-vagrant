#!/bin/bash

yum install -y unzip

cd /apps/dist
wget https://github.com/archivesspace/archivesspace/releases/download/v1.5.1/archivesspace-v1.5.1.zip

mkdir -p /apps/aspace
cd /apps/aspace
unzip /apps/dist/archivesspace-v1.5.1.zip

chown -R vagrant:vagrant /apps/aspace
