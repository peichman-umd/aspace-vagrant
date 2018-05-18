#/bin/bash

mysql -u root <<END
CREATE DATABASE archivesspace default character set utf8;
CREATE USER 'as'@'localhost' IDENTIFIED BY 'as';
GRANT ALL PRIVILEGES ON archivesspace.* TO 'as'@'localhost';
END
