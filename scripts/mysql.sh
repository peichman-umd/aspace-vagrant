#!/bin/bash

# start MySQL now and on every startup
/sbin/service mysqld start
/sbin/chkconfig mysqld on
