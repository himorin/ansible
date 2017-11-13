Site specific configuration
******

This collection of roles in ics\_ansible repository is used at various sites 
for PFS development, such as the production (at the summit / Subaru) and AIT 
sites, configurations including internal network could differ over site by 
site. 
To switch site-wide configuration over entire roles, PFS ICS ansible has 
one group variables configuration file per each site as site\_\<domain\>.yml 
file in group\_vars. 
Each playbook is required to read this file by placing a line of 
"group\_vars/site\_{{ ansible_dns.domain }}.yml" in vars\_files, 
with \<domain\> named as site domain name (configured in dnsmasq, mostly). 

Updating configuration files
======

To update configuration files, follow procedures below for each case.

1. **Update by changes to roles**: 
  Submit required changes to site configuration files in the same PR as the 
  code change. On adding configuration, items are required to be added (at 
  least) to the production configuration file if applicable.
  Also update list of configurations in this document, if any. 
2. **Update configuration for the production**:
  Follow a normal procedure as code, by filing a new ticket, adding a new 
  branch, PR and merge. 
3. **Update configuration for others**:
  Either following a normal procedure or just pushing updated items to master 
  are fine. 

Organization of configurations
======

Configurations are organized as `site\_config.\<service\>.\<item\>`, and 
`\<item\>` could have value, list, or dict. Services are organized as target 
services listed below. 

List of services and their items.

- `cron\_apt`: cron\_apt package configuration (periodic system package update)

  - `hour`: Target hour to run update

- `dnsmasq`: DHCP/DNS server configuration (dnsmasq package)

  - `site`: Site name to be used (refer ics\_dnsmasq repository)

- `elastic`: Elastic services configuration

  - `server`: Target server name to push from client
  - `storage_nfs`: NFS mount point of storage for Elasticsearch server

- `grafana`: Grafana service configuration

  - `url`: URL exposed to external via reverse proxy

- `ldap`: LDAP server information

  - `uri`: URI of LDAP server
  - `base`: Base DN to use

- `mail`: System mail configuration

  - `notice_from`: Email address used for notification from services
  - `notice_name`: Name in email from
  - `smarthost`: Smarthost name to be used at clients

- `munin`: Munin service configuration

  - `cidr`: CIDR of connection to be allowed

- `nfs`: NFS mount point lists, each item in this shall have a list of dict 
  with `source` (source of server) and `target` (mount point). 

  - `common`: System wide mount points

- `ntp`: NTP service configuration

  - `upstream`: Upstream NTP server address
  - `local`: NTP server hosted in PFS ICS system

- `packages`: List of packages to be installed, each item in this shall have 
  a list of package names.

  - `sitewide`: Site-wide list of packages

- `prometheus`: Prometheus service configuration

  - `server`: Prometheus server name
  - `external_url`: URL exposed to external via reverse proxy
  - `route_prefix`: Prefix used in URL exposed to external
  - `log_format`: Syslog output format from Prometheus service
  - `storage_nfs`: NFS mount point of storage for Prometheus server

- `rsyslog`: rsyslog service configuration

  - `server`: rsyslog server to push
  - `repush`: If rsyslog server is required to push to another service, put 
    line here.

- `system\_accounts`: List of system accounts

  - `groups`: List of dict for system groups to be set. Dict need to have 
    `gname` as group name and `gid` as GID. 
  - `users`: List of dict for system accounts to be set. Dict need to have 
    `uname` as user name, `uid` as UID, `home` as home directory, `group` 
    as default group (one in `groups` could be used), `groups` as additional 
    group name to be put, and `shell` for default shell. 

- `virt`: libvirt services configurations

  - `nfsdisk`: NFS mount for disk images
  - `pki`: PKI configuration for libvirt

    - `local`: PKI file source at generation host
    - `subj`: Subject (C,ST,L,O) for generated certifications

