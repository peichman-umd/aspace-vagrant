#!/bin/bash

# Oracle JDK
JDK=$(find /apps/dist -maxdepth 1 -type f -name 'jdk-*.tar.gz' | tail -n1)
if [ -z "$JDK" ]; then
    echo >&2 "No JDK found. Please download an Oracle JDK tar.gz and place it in /apps/dist"
    exit 1
fi
echo "Found JDK in $JDK"
tar xzvf "$JDK" --directory /apps
# find the newly extracted JDK
JAVA_HOME=$(find /apps -maxdepth 1 -type d -name 'jdk*' | tail -n1)
ln -s "$JAVA_HOME" /apps/java
cat > /etc/profile.d/java.sh <<END
export JAVA_HOME=$JAVA_HOME
export PATH=\$JAVA_HOME/bin:\$PATH
END
