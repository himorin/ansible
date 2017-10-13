Debian preseed configurations and tools
******

Preseed configurations
======

Common configurations
------

Followings are applied to all preseed configuration files otherwise noted.

- Language en / Country US
- Locale en_US.UTF-8
- Keymap pc105
- Network by DHCP (both hostname, IP address)
- APT source as deb.debian.org, without proxy, with security, both non-free and contrib enabled
- Clock as UTC for hardware, US/Hawaii for OS
- NTP to PFS ICS NTP server
- Partition table as:

  - 512MB ext3 for "/boot"
  - 1GB (to 4GB) swap
  - Remaining all as xfs for "/"

- root login disabled, shadow and sudo enabled
- normal account as uname="pfs" and uid="1000"

  - password need to be set at ISO creation (with editing configuration file - 
    made by mkpasswd, whose output cannot be added to public repository)
  - have ssh public key for remote access (ed25519 one)

- Grub installed to boot sector, with target only to installed one
- Power off after installation finished and CD ejected (not reboot)

Following packages are installed:

- Minimum system requirement ("standard" tasksel)
- openssh-server
- aptitude
- ansible

Installation target need to be defined to match with hardware configuration, 
which affects to two parameters: 

- partman-auto/disk
- grub-installer/bootdev

Tools
======

preseed.sh
------

This script is provided to build customized ISO images from officialy provided 
bootable ISO images. To run, execute 'preseed.sh <original_iso> <config>' 
at where specified two files exist, and '<config>.iso' will be created. 
You need to run under sudo-able account, since this script use mount to 
extract original ISO image. 

If you source non-password configured configuration file, you need to modify 
a line of "password/user-password-crypted" with a result of 
"mkpasswd -m sha-512 -S <salt> -s <password>".

System requirements:

- rsync
- gzip/gunzip, cpio
- md5sum
- genisoimage


