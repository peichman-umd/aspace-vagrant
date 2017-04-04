#!/bin/bash

SERVICE_USER_GROUP=vagrant:vagrant

# Aspace
ASPACE_VERSION=1.5.4
ASPACE_PKG=/apps/dist/archivesspace-v${ASPACE_VERSION}.zip
# look for a cached tarball
if [ ! -e "$ASPACE_PKG" ]; then
    ASPACE_PKG_URL=https://github.com/archivesspace/archivesspace/releases/download/v${ASPACE_VERSION}/archivesspace-v${ASPACE_VERSION}.zip
    curl -Lso "$ASPACE_PKG" "$ASPACE_PKG_URL"
fi


cd /apps
unzip "$ASPACE_PKG"
mv archivesspace "archivesspace-${ASPACE_VERSION}"

mkdir -p /apps/aspace/aspace/{data,logs}
chown -R "$SERVICE_USER_GROUP" /apps/aspace /apps/"archivesspace-${ASPACE_VERSION}"/config
