#!/bin/bash

SERVICE_USER_GROUP=vagrant:vagrant

ENV_SRC_DIR=/apps/git/aspace-env/
ENV_TARGET_DIR=/apps/aspace
rsync -av --progress $ENV_SRC_DIR $ENV_TARGET_DIR --exclude .git
chown -R "$SERVICE_USER_GROUP" "$ENV_TARGET_DIR"
