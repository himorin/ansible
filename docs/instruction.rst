Instruction to run ansible
======

Once you prepare a target host (as VM guest or physical host), execute as 
follows:

1. git clone ics_ansible repository to your local host (some host for work)
2. Check 'ansible' and 'sshpass' packages are installed at your local host
3. ssh to the target host, to ensure a public key of the target host is 
   correctly in a known_hosts at your local host
4. Check inventory file for configuration of the target host

then, run ansible as 
'ansible-playbook -k -K -i INVENTORY-FILE -l TARGET-HOSTNAME PLAYBOOK'.

Manual configurations
======

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

