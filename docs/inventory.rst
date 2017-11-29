Sections in inventry
======

A playbook named 'site.yml' is provided for configuration of normal instances. 
As well as section for 'all' hosts group, several sections are defined as below 
per service. 
Inventory files shall be organized as 'inventory-<sitename>', like 
'inventory-subaru', which lists target hosts per sections. Some sections
require special options described below, especially for 'server'. 

Section 'all'
------

'all' section is defined to run site wide tasks like creating system accounts, 
installation of packages for system monitoring. Some roles conflict with 
infrastructural system service configurations, like ntp-server and ntp-client, 
which should be configured into all instances except for instance to serve 
the service, and some flags are defined for these instances (refer 
`Section 'server'`_).

Section 'server'
------

'server' section is to gather hosts which run system wide service configured 
in 'all' section, such as ntp. All hosts in this section shall have flag(s) 
listed below to specify service configured, not to make conflict on running 
roles in 'all' and 'server'. 

- 'server_ntp': host to run NTP configured by 'ntp-server'
- 'server_rsyslog': host to run rsyslog server configured by 'rsyslog-server'

Section 'virt-host'
------

'virt-host' section lists VM host servers. 
Before putting new VM host server into a inventory file, creation of host 
certificate for the target VM host server is required by running scripts 
configured by 'privca' role.

Section 'actor'
------

'actor' section lists hosts to run actors (and tron server). 

