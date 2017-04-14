#/bin/bash

MYSQL_JDBC_VERSION=5.1.38

# install JDBC driver
cd /apps/aspace/archivesspace
curl -Lso lib/mysql-connector-java-${MYSQL_JDBC_VERSION}.jar \
    https://maven.lib.umd.edu/nexus/service/local/repositories/central/content/mysql/mysql-connector-java/${MYSQL_JDBC_VERSION}/mysql-connector-java-${MYSQL_JDBC_VERSION}.jar

# set up MySQL database
mysql -u root <<END
CREATE DATABASE archivesspace;
CREATE USER 'as'@'localhost' IDENTIFIED BY 'as';
GRANT ALL PRIVILEGES ON archivesspace.* TO 'as'@'localhost';
END

# create tables
source /apps/aspace/config/env
scripts/setup-database.sh
