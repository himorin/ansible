#! /bin/bash

C_TARGET=$1
C_DAYS=1825
C_TGTCN="{{ site_config.virt.pki.subj }}/CN=${C_TARGET}"

cd {{ site_config.virt.pki.local }}

openssl req -new -newkey rsa:4096 -nodes -days $C_DAYS -sha256 -out newcerts/${C_TARGET}.csr -keyout private/${C_TARGET}.key -subj ${C_TGTCN}
openssl ca -config ./openssl.cnf -days $C_DAYS -policy policy_anything -out certs/${C_TARGET}.pem -infiles newcerts/${C_TARGET}.csr

echo "Dump signed cert"
openssl x509 -noout -text -in certs/${C_TARGET}.pem

