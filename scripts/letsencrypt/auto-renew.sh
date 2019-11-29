#!/bin/bash

certbot certonly -n --manual-public-ip-logging-ok --server https://acme-v02.api.letsencrypt.org/directory --agree-tos --non-interactive --manual --preferred-challenges=dns --email email@email.de --manual-auth-hook /opt/letsencrypt/dns-auth.sh -d *.DOMAIN1.de -d DOMAIN1.de
certbot certonly -n --manual-public-ip-logging-ok --server https://acme-v02.api.letsencrypt.org/directory --agree-tos --non-interactive --manual --preferred-challenges=dns --email email@email.de --manual-auth-hook /opt/letsencrypt/dns-auth.sh -d *.DOMAIN2.de -d DOMAIN2.de


### Delete if using Nginx
apachectl -k graceful


### Delete if using Apache
/etc/init.d/nginx reload
