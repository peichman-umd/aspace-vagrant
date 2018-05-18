#!/bin/bash

DIST_DIR=/apps/dist
HOSTNAME=$1
IP_ADDRESS=$2

if [ -e "$DIST_DIR/$HOSTNAME/ssl" ]; then
    echo "Using HTTPS SSL configuration cached in $DIST_DIR/$HOSTNAME/ssl"
else
    # SSL Certificate (self-signed)
    mkdir -p "$DIST_DIR/$HOSTNAME"/ssl/{key,csr,cert,cnf}

    KEY="$DIST_DIR/$HOSTNAME/ssl/key/${HOSTNAME}.key"
    CSR="$DIST_DIR/$HOSTNAME/ssl/csr/${HOSTNAME}.csr"
    CRT="$DIST_DIR/$HOSTNAME/ssl/cert/${HOSTNAME}.crt"
    CNF="$DIST_DIR/$HOSTNAME/ssl/cnf/${HOSTNAME}.cnf"

    cat > "$CNF" <<END
[ req ]
prompt             = no
distinguished_name = ${HOSTNAME}_dn
req_extensions     = v3_req

[ ${HOSTNAME}_dn ]
commonName              = ${HOSTNAME}
stateOrProvinceName     = MD
countryName             = US
organizationName        = UMD
organizationalUnitName  = Libraries

[ v3_req ]
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${HOSTNAME}
DNS.2 = localhost
IP.1  = ${IP_ADDRESS}
IP.2  = 127.0.0.1
END

    # Generate private key 
    openssl genrsa -out "$KEY" 2048

    # Generate CSR 
    openssl req -new -key "$KEY" -out "$CSR" -config "$CNF"

    # Generate self-signed cert
    openssl x509 -req -days 365 -in "$CSR" -signkey "$KEY" -out "$CRT" \
        -extensions v3_req -extfile "$CNF"
fi

find "$DIST_DIR/$HOSTNAME/ssl" -type f -exec cp {} /apps/aspace/ssl/certs \;
