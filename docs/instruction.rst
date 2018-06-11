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

