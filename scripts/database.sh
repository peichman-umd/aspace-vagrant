#/bin/bash

ASPACE_VERSION=1.5.2
MYSQL_JDBC_VERSION=5.1.38

# set up MySQL database
cd /apps/"archivesspace-${ASPACE_VERSION}"
curl -Lso lib/mysql-connector-java-${MYSQL_JDBC_VERSION}.jar \
    https://maven.lib.umd.edu/nexus/service/local/repositories/central/content/mysql/mysql-connector-java/${MYSQL_JDBC_VERSION}/mysql-connector-java-${MYSQL_JDBC_VERSION}.jar
scripts/setup-database.sh
