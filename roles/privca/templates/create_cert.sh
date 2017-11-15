#! /bin/bash

C_TARGET=$1
C_DAYS=1825

E_DIG_IP=`dig +short ${C_TARGET}`
if [ ! -n "$E_DIG_IP" ]; then
  echo "Could not resolv name '$C_TARGET'"
  exit
fi

E_DIG_FQ=`dig +short -x ${E_DIG_IP}`
E_DIG_FQ=${E_DIG_FQ:0:-1}
E_DIG_HN=${E_DIG_FQ%%.*}

C_TGTCN="{{ site_config.virt.pki.subj }}/CN=${E_DIG_IP}"
C_ALTS="[SAN]\nsubjectAltName='DNS:${E_DIG_FQ},DNS:${E_DIG_HN}'"
C_TARGET=$E_DIG_IP

echo "Target configuration:"
echo "  IP address: $E_DIG_IP"
echo "  Host FQDN : $E_DIG_FQ"
echo "  Hostname  : $E_DIG_HN"


cd {{ site_config.virt.pki.local }}

openssl req -new -newkey rsa:4096 -nodes -days $C_DAYS -sha256 \
    -out newcerts/${C_TARGET}.csr -keyout private/${C_TARGET}.key \
    -subj ${C_TGTCN} \
    -extensions SAN -reqexts SAN \
    -config <( cat ./openssl.cnf <( printf "$C_ALTS"))
openssl ca -days $C_DAYS -policy policy_anything \
    -extensions SAN \
    -config <( cat ./openssl.cnf <( printf "$C_ALTS")) \
    -out certs/${C_TARGET}.pem -infiles newcerts/${C_TARGET}.csr

echo "Dump signed cert"
openssl x509 -noout -text -in certs/${C_TARGET}.pem

