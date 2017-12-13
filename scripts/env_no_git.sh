#!/bin/bash

SERVICE_USER_GROUP=vagrant:vagrant

ENV_SRC_DIR=/apps/git/aspace-env
ENV_TARGET_DIR=/apps/aspace

cp -r $ENV_SRC_DIR $ENV_TARGET_DIR
chown -R "$SERVICE_USER_GROUP" "$ENV_TARGET_DIR"
chmod -R +x $ENV_TARGET_DIR/scripts
