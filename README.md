## 1. Install new VM
- Debian (512MB to 1GB RAM / 1 CPU / 2GB Disk - 512MB Swap)
- Bind9 `# apt-get install -y bind9`

### Configure Bind9:

**/etc/bind/zones.rfc1918** add

```
_acme-challenge IN NS ns1.midworld.de.
_acme-challenge IN NS ns2.midworld.de.
```

**/etc/bind/named.conf** add

```
zone "_acme-challenge.DOMAIN1.de" {
        type master;
        file "/var/bind/dyn/_acme-challenge.DOMAIN1.de.zone";
        allow-query { any; };
        allow-update { localhost; };
        
};

zone "_acme-challenge.DOMAIN2.de" {
        type master;
        file "/var/bind/dyn/_acme-challenge.DOMAIN2.de.zone";
        allow-query { any; };
        allow-update { localhost; };
        
};
```
You have to add all domains you want to auto-update the certificates.

## 2. Edit VM with Letsencrypt installation

- `# mkdir /opt/letsencrypt`
- copy the 2 files from repository (scripts/letsencrypt) to /opt/letsencrypt
- *dns-auth.sh:* change line 11 to your above new created VM-IP
- *auto-renew.sh:* change email and domain to your needs in every line. You have to add 1 line for every domain you want to auto-update the certs. This have to be similar with the above `/etc/bind/named.conf`
- `# chown +x /opt/letsencrypt/dns-auto.sh`
- `# chown +x /opt/letsencrypt/auto-renew.sh`
- `# crontab -e`
- add `35 3 1 * * /bin/bash /opt/letsencrypt/auto-renew.sh >/dev/null 2>&1`

## 3. Edit Proxmox Server

- `# mkdir /opt/cronvm`
- copy the 1 file from repository (scripts/proxmox) to /opt/cronvm
- `# chown +x /opt/cronvm/controlvm.sh`
- `# crontab -e`
- add and edit [XXX] to the ID of your in step 1 installed Bind9-VM
```
30 3 1 * * bash -x /opt/cronvm/controlvm.sh start XXX >/dev/null 2>&1
59 3 1 * * bash -x /opt/cronvm/controlvm.sh shutdown XXX >/dev/null 2>&1
```
