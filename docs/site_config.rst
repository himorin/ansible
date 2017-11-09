Site specific configuration
======

To switch site-wide configuration over multiple playbooks, PFS ICS ansible 
requires site\_\<domain\>.yml in group\_vars with following variables. 
This file will be read from each playbook as vars_files of 
"group\_vars/site\_{{ ansible_dns.domain }}.yml", so \<domain\> part need to 
be named as site domain name (in dnsmasq, mostly). 

- ntp: list of NTP servers
- munin\_cidr: network address range (in CIDR) which munin-node accepts connection
- cron\_apt\_hour: hour in a day of cron-apt
- dnsmasq.site: site name used for dnsmasq
- exim4\_smarthost: email relay server
- grafana.url: Grafana server publish end point URL (at grafana server)
- ldap\_uri: URI of LDAP server
- ldap\_base: LDAP base DN to be read
- mail.notice_from: Email notification from address
- mail.notice_name: Email notification mail name
- nfs.common: system wide NFS targets, list of hash 'source' and 'target'
- packages.sitewide: List of packages to be installed over site wide
- prometheus.server: Prometheus server hostname (used for metrics)
- prometheus.external_url: External publish end point URL
- prometheus.route_prefix: Path prefix for external publish end point
- prometheus.log_format: Prometheus server log format
- prometheus.storage_nfs: NFS target for local storage
- rsyslog.server: rsyslog udp/tcp server to push
- rsyslog.repush: push target at rsyslog server for after processing
- virt.nfsdisk: VM client disk storage (NFSv3)
- virt.pki.local: VM host PKI file source at local
- virt.pki.subj: PKI subjects (C,ST,L,O)


