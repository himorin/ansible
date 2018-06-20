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

nfs-client
------

This role will add mount definition for NFS, and designed to be called by 
other role(s). 
Target (IP address and export point) and mount point are passed to this role 
at calling as variables. 

- Required configuration items

  - 'nfsv3_target': list of dict (with 'source' and 'target') need to be passed.

- No dependencies
- Remarks

  - As for now only nfsv3 is supported.
  - For per site mount points used in role(s) , it is encouraged to be defined 
    as a list in 'site_config.nfs'. 

nfs-server
------

This role will configure NFSv3 export. Target directories at NFSv3 server local 
are passed to this role at calling as variables 'nfsv3_export'.

- Required configuration items

  - 'nfs.v3export_access': NFSv3 export configuration (address block and 
    condition to be put into '/etc/exports')

- Deneds on 'packages' role
- Remarsk

  - This role will configure all target directories with the same NFSv3 export 
    configuration. 

ntp
---

This role will confiugre NTP client. 

- Required configuration items

  - ntp.local (no default value)

- No dependencies
- Remarks

  - This role will remove all pool definitions from ntp.

packagecloud
------

This role will configure apt-line for specified packagecloud repository, 
but not install any package. Use `packages` role to install packages following 
this role in meta section. Target site is operated under https, so this will 
install https handler for apt, also. 

- No required configuration item
- No dependencies
- Remarks

  - Additional apt-key will be added per each apt-line.

packages
------

This role will install packages, and designed to be called by other role(s). 
List of packages to be installed are passed to this role at calling as 
variables. 

- Required configuration items

  - 'packages': list of packages, options can be passed as dict in the list.
    If item in the list is a simple variable, just pass specified variable as 
    a package name, or use value as dict. The dict can have 'package' (name 
    of package to be installed) and 'enable_service' (name of service to be 
    enabled via systemd).

- No dependencies
- Remarks

  - 'openssh' is required to be installed by preseeded installation media.
  - For a list changed per site, it is encouraged to be defined as a list in 
    'site_config.packages'. 

rsyslog-client
------

This role will configure rsyslog as client to push all syslog lines via imudp 
to the rsyslog server. 

- Required configuration items

  - rsyslog.server (no default value)

- No dependencies
- Remarks

  - This role will not configure to push if incoming imudp is enabled.

system-accounts
------

This role will setup system users and group. 

- Required configuration items

  - system_accounts.groups
  - system_accounts.users

- No dependencies
- Remarks

  - This role will create all groups first, to enable users be in specific 
    groups.

virt
----

This role will configure libvirt environment, with PKI and br0. 

- Required configuration items

  - virt.nfsdisk (no default value)
  - virt.pki.local (no default value)

- Dependencies

  - privca (also need to run script and certificates created)

- Remarks

  - This role will modify the default network interface into bridge (br0) 
    with static IP address configuration. 
  - This role will reboot target host for network configuration (br0) 

hwraid
------

This role will configure and install hardware RAID related package.

- No required configuration items
- Dependencies

  - packages role to setup apt-transport-https
  - Packages are taken from hwraid.le-vert.net, and will confiugre apt-source

- Remarks

  - Target host need to have per host parameter

    - If 'hwraid_target_sas2' is defined to host, LSI FusionMTP SAS2 installed
    - If 'hwraid_target_megasas' is defined to host, LSI MegaRAID SAS 
      (Dell PERC) installed

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

privca
------

This role will configure environment to build private CA and install some 
scripts for certs generation. 

- Required configuration items

  - virt.pki.local (no default value)
  - virt.pki.subj (no default value)

- No dependencies
- Remarks

  - This role will not run script to build root CA nor certificates. Run 
    scripts installed into home directory. 

prometheus
------

This role will install and configure prometheus server with skelton to target 
hosts. 
Skelton files for list of targets are installed into 
'/etc/prometheus/scrape_configs' and loaded from files configured by this role. 

- Required configuration items

  - prometheus.external_url (no default value)
  - prometheus.route_prefix (no default value)
  - prometheus.log_format (no default value)
  - prometheus.storage_nfs (no default value)

- No dependencies
- Remarks

  - Some skelton files for list of target hosts are installed, but need to be 
    edited after running role.

prometheus-exporters
------

This role will install and configure various exporters for prometheus, depends 
on defined vars per target host. Flag to install exporters are defined as 
`prometheus_exporters_xxxx` (see list of exporters below for one in `xxxx`)
and need to be defined per target host. 
Configurations are required per each target exporter, and account information 
to connect database are prompted on ansible-playbook execution but not be 
saved in vars configuration files (even not in vault). Just type enter 
without any string for which exporters for database (in mysql or pgsql) you 
will not use/configure or don't want to change configuration. 

Some exporters does not have package to be installed via package manager, 
you need to have binary in go repository of your local machine by building 
(e.g. go get) from github etc. before executing ansible. 
Also for these, no systemd script is supplied, and this role just installs 
script to be run by cron at @reboot. 

Current supported exporters (flag name are in bracket, if no bracket is added 
flag name is the same to name) are:

- ipmi : require to load kernel module (no reboot)
- snmp : require binary at local, no systemd script, compile snmp.yml on 
  execution (see detail in remarks)
- mysql : prompted for account (see detail in remarks)
- pgsql : prompted for account (see detail in remarks)
- elasticsearch (es) : require binary at local, no systemd script

- Required configuration items

  - prometheus_exporter.mysql.host (no default value)
  - prometheus_exporter.pgsql.host (no default value)

- Dependencies

  - Require pre built binary at local go repository for snmp, elasticsearch

- Remarks

  - snmp exporter requires mib mapping information to convert oids into 
    prometheus name/labels, by default to `snmp.yml` and can have only one 
    definition file. Startup script will combine all yml files (`snmp_*.yml`) 
    in snmp exporter directory to build configuration file used by the 
    instance. 
  - mysql database account need to have 'select' and 'replication client' 
    priviledges on *.* (all databases) to acquire performance parameters 
    per database. 
  - pgsql database account need to have suitable priviledges to run operation. 

rsyslog-server
------

This role will configure rsyslog server to accept syslog push via udp/tcp, 
and to proxy lines after processing pushed syslog lines if 
'site_config.rsyslog.repush' is configured. 

- No required configuration items
- No dependencies
- Remarks

  - Will not touch local output lines, so comment them out by hand if in need. 
  - Will not install template for proxy if 'site_config.rsyslog.repush' is not 
    defined. 

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


