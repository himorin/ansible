Roles in ics\_ansible repository
******

Roles in this collection are described below (in alphabetical order).
For each role, 

- Configuration after execution of role
- Required configuration items (both site configuration and passed on call)
- Dependencies
- Remarks

are listed. Required configuration with '(no default value)' notes required 
ones, which leads fail if not defined. Refer document on site configurations 
for their mean/target of configurations listed. 

Roles are categolized into three: 

- `Roles for system configuration`_
- `Roles for service configuration`_
- `Roles for PFS configuration`_

Roles for system configuration
======

cron-apt
------

This role will install and configure cron-apt (periodic system package update 
cron job) into the system (Ubuntu/Debian), to run at hour specified in 
site configuration. 

- Required configuration items

  - cron_apt.hour (no default value)

- no dependency
- Remarks

  - This role will configure cron-apt to upgrade package automatically everyday.

ldap
----

This role will configure ldap client for system and account authentication. 

- Required configuration items

  - ldap.base (no default value)
  - ldap.uri (no default value)

- No dependencies
- Remarks

  - No filtering by group for now. All in ldap.base will be loaded into system.

munin-node
------

This role will configure munin-node client. 

- Required configuration items

  - munin.cidr (no default value)

- No dependencies
- Remarks

  - Will not configure plugins more than default ones.

nfs
---

This role will add mount definition for NFS. 
Target (IP address and export point) and mount point are passed to this role 
at calling as variables. 

- Required configuration items

  - 'nfsv3_target': list of dict (with 'source' and 'target') need to be passed.

- No dependencies
- Remarks

  - As for now only nfsv3 is supported.

Roles for service configuration
======

dnsmasq
------

This role will install dnsmasq and configure using ics_dnsmasq repository. 
Refer ics_dnsmasq repository for detailed configuration scheme of DNS/DHCP 
service. 

- Required configuration items

  - dnsmasq.site (no default value)

- Dependencies

  - iptables (role)

- Remarks

  - This role will not configure target host to be statically assigned IP address. 
  - In some (old version) distribution, you need to place '/etc/dnsmasq.d/README' after configuration. 

exim4
----

This role will install and configure exim4 in satellite mode, with smarthost 
specified in site configuration. 

- Required configuration items

  - mail.smarthost (no default value)

- No dependencies
- No remarks

grafana
------

This roll will install and configure grafana server. 

- Required configuration items

  - grafana.url (no default value)

- Dependencies

  - This role will install package from packagecloud.io

- Remarks

  - This role will configure minimum part in grafana.ini, so you need to edit 
    grafana.ini for database, session, seciruty and auth by hand - after 
    configuration of other services like database.

Roles for PFS configuration
======

eups
----

This role will install and configure eups, add some required shell environments 
in .bashrc file, and place a symlink to setups script at home directory. 
To run and use eups package/version management tools, you need to run a shell 
script at your home directory after logged in to bash shell. 

- No required configuration items
- No dependencies
- Remarks

  - No package is installed after running this role.


  
  
  
TBW
===
  
  
ntp
---

  Configure NTP
packages
  Install packages specified by playbook argument 'packages'.
  List of packages are listed in 'packages' in site config.
  Note, openssh and ansible are required to be installed by preseeded 
  installation media.
privca
  Configure environment to build private CA (not to build CA)
prometheus
  Configure prometheus server with skeltons for targets.
rsyslog-client
  Configure rsyslog to push all syslog lines to site_config.rsyslog.server 
  via udp.
rsyslog-server
  Configure rsyslog as accepting lines via udp/tcp.
  Will not touch local output lines, so comment them out by hand if in need. 
  If site_config.rsyslog.repush is configured, will put config file to repush 
  syslog lines to after processing.
system-accounts
  Setup commonly required system users and groups
virt
  Setup libvirt environment, with PKI and br0 configuration. (reboot required)


skelton
======

- Required configuration items
- Dependencies
- Remarks


