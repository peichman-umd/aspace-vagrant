#!/bin/bash

SERVICE_USER_GROUP=vagrant:vagrant

# Aspace
ASPACE_VERSION=1.5.2
ASPACE_PKG=/apps/dist/archivesspace-v${ASPACE_VERSION}.zip
# look for a cached tarball
if [ ! -e "$ASPACE_PKG" ]; then
    ASPACE_PKG_URL=https://github.com/archivesspace/archivesspace/releases/download/v${ASPACE_VERSION}/archivesspace-v${ASPACE_VERSION}.zip
    curl -Lso "$ASPACE_PKG" "$ASPACE_PKG_URL"
fi



# unzip without overwriting existing files
unzip -n -d /apps/aspace "$ASPACE_PKG"
chown -R "$SERVICE_USER_GROUP" /apps/aspace/archivesspace
