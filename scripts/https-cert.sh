#!/bin/bash

CACHED_SSL_CONF=/apps/dist/ssl

if [ -e "$CACHED_SSL_CONF" ]; then
    echo "Using HTTPS SSL configuration cached in dist/ssl"
    cp -rp /apps/dist/ssl /apps
else
    for HOSTNAME in aspacelocal archiveslocal; do
        IP_ADDRESS=192.168.40.100

        # SSL Certificate (self-signed)
        mkdir -p /apps/ssl/{key,csr,cert,cnf}

        KEY=/apps/ssl/key/${HOSTNAME}.key
        CSR=/apps/ssl/csr/${HOSTNAME}.csr
        CRT=/apps/ssl/cert/${HOSTNAME}.crt
        CNF=/apps/ssl/cnf/${HOSTNAME}.cnf

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

        # cache the SSL cert info for the next run of Vagrant
        cp -rp /apps/ssl /apps/dist
    done
fi
