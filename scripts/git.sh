#!/bin/bash

NAME=$1
EMAIL=$2

git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global color.ui true
