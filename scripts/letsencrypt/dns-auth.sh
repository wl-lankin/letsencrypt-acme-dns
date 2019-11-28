#!/bin/bash

if [ -z "$CERTBOT_DOMAIN" ] || [ -z "$CERTBOT_VALIDATION" ]
then
exit -1
fi

HOST="_acme-challenge"

/usr/bin/nsupdate << EOM
server 0.0.0.0
zone ${HOST}.${CERTBOT_DOMAIN}
update delete ${HOST}.${CERTBOT_DOMAIN} TXT
update add ${HOST}.${CERTBOT_DOMAIN} 300 TXT "${CERTBOT_VALIDATION}"
send
EOM
