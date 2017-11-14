Roles in ics\_ansible repository
******

Roles in this collection are described below (in alphabetical order).
For each role, 

- Configuration after execution of role
- Required configuration items (both site configuration and passed on call)
- Dependencies
- Remarks

are listed.

Configuration after execution
------

Required configuration items
------

Dependencies
------

Remarks
------


cron-apt
======

Configuration after execution
------

This role will install and configure cron-apt (periodic system package update 
cron job) into the system (Ubuntu/Debian). 

Required configuration items
------

- 

Dependencies
------

Remarks
------


dnsmasq
======

  'dnsmasq' service install and configuration (using ics_dnsmasq repo)

eups
====

  Install of eups, and its required python packages

exim4
====

  Configuration of exim4 as satellite host
:grafana:
  Configure grafana server (need additional configuration for auth)
:ldap:
  Configuration of ldap for account
:munin-node:
  Configuration of munin-node
:nfs:
  Mount NFSv3 for targets specified by playbook argument 'nfsv3_target'
:ntp:
  Configure NTP
:packages:
  Install packages specified by playbook argument 'packages'.
  List of packages are listed in 'packages' in site config.
  Note, openssh and ansible are required to be installed by preseeded 
  installation media.
:privca:
  Configure environment to build private CA (not to build CA)
:prometheus:
  Configure prometheus server with skeltons for targets.
:rsyslog-client:
  Configure rsyslog to push all syslog lines to site_config.rsyslog.server 
  via udp.
:rsyslog-server:
  Configure rsyslog as accepting lines via udp/tcp.
  Will not touch local output lines, so comment them out by hand if in need. 
  If site_config.rsyslog.repush is configured, will put config file to repush 
  syslog lines to after processing.
:system-accounts:
  Setup commonly required system users and groups
:virt:
  Setup libvirt environment, with PKI and br0 configuration. (reboot required)


