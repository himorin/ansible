# Instruction to run ansible

Once you prepare a target host (as VM guest or physical host), execute as 
follows:

1. git clone ics_ansible repository to your local host (some host for work)
2. Check 'ansible' and 'sshpass' packages are installed at your local host
3. ssh to the target host, to ensure a public key of the target host is 
   correctly in a known_hosts at your local host
4. Check inventory file for configuration of the target host

then, run ansible as 
`ansible-playbook -k -K -i INVENTORY-FILE -l TARGET-HOSTNAME PLAYBOOK`.

* you need to enable authorized_keys if you use ssh-agent locally

# Manual configurations

mysql
------

1. run ansible first
2. delete `/services/mysql/` and move `/var/lib/mysql` to there
   (database assets contains debian-maintainance values)
3. re-run ansible

mod_php
------

- php version need to be configured by parameter
- may need to run twice, for a2enmod restriction (or may need to disable once configured, and re-run)

ipv6
------

IPv6 is not enabled by preseed, so need to be added by hand.

1. edit iptables/rules.v6 with assigned IPv6 address
2. add ipv6 line to network/interfaces, e.g. `iface ens3 inet6 dhcp`
3. reboot (or from console, restart netfilter-persistent, and down/up ens3)
