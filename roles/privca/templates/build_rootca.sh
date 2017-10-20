#! /bin/bash

F_CAKEY=private/cakey.pem
F_CACERT=cacert.pem
C_DAYS=1825

F_CONF=./openssl.cnf

cd {{ site_config.virt.pki.local }}
openssl genrsa -aes256 -out $F_CAKEY 4096
chmod 600 $F_CAKEY
openssl req -config $F_CONF -key $F_CAKEY -new -x509 -days $C_DAYS -sha256 -extensions v3_ca -out $F_CACERT -subj {{ site_config.virt.pki.subj }}

echo "Dump CA made"
openssl x509 -noout -text -in $F_CACERT

