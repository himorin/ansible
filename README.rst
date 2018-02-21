This repository is for host and software configuration for PFS ICS. 
All production hosts need to be configured using this ansible playbooks, 
except for special cases, like hosts with PXE boot required.

ToC
***

- `List of definitions`_
- `Configurations to use`_
- `Definitions and requirements on modification`_
- `Support files`_

List of definitions
******

Roles
=====

:cron-apt:
  Periodic package update using cron-apt
:dnsmasq:
  'dnsmasq' service install and configuration (using ics_dnsmasq repo)
:eups:
  Install of eups, and its required python packages
:exim4:
  Configuration of exim4 as satellite host
:gitlfs:
  Configure git-lfs from packagecloud and install
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

Playbooks
======

(Note: for now, no official playbook is defined yet. Pick roles and write 
playbook referring site.yml.)

:site.yml:
  Temporary playbook for test

Configurations to use
******

Before using this set of playbooks, system administrator at each site needs to 
configure variables (refer 
`Site specific configuration document <docs/site_config.rst>`_) and inventories 
(`Sections in inventry`_) following this section. These definitions are used 
to change configurations for multiple playbooks shared among multiple sites, 
and are required to be configured per site. 

Sections in inventry
======

Following sections are used.

- (TBD)

Definitions and requirements on modification
******

To write roles and playbooks, following points are required to be considered. 

- Have version number to be installed in vars but not in task directly
- Make dependency to other roles as less as possible, and put comment of dependency

Support files
******

Some support files and tools are added in [misc](/misc/) directory, as follows:

:[Debian preseed](/misc/debian-preseed/):
  ICS project wide pre-seeded Debian OS installation configuration files and 
  tools to build custom ISO images. Check details in README.
  System configurations after installation using built ISO images are assumed 
  to be done by Ansible, preseed configurations are to install bare OS with 
  Ansible to run. 


