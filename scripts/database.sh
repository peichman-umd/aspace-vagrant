#/bin/bash

MYSQL_JDBC_VERSION=5.1.38

# set up MySQL database
cd /apps/aspace/archivesspace
curl -Lso lib/mysql-connector-java-${MYSQL_JDBC_VERSION}.jar \
    https://maven.lib.umd.edu/nexus/service/local/repositories/central/content/mysql/mysql-connector-java/${MYSQL_JDBC_VERSION}/mysql-connector-java-${MYSQL_JDBC_VERSION}.jar

source /apps/aspace/config/env
scripts/setup-database.sh
