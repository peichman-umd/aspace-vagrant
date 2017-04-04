#!/bin/bash

for port in "$@"; do
    firewall-cmd --zone=public --add-port="$port"/tcp --permanent
done

if [ $# -gt 0 ]; then
    firewall-cmd --reload
fi
