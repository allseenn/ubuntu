# Encrypt folder

How to encrypt data with [veracrypt](https://veracrypt.io) container for automatic mount with [pam_mount](https://wiki.archlinux.org/title/Pam_mount) and [pam.d](https://wiki.archlinux.org/title/Pam.d).

## Installation

### RedHat

```bash
wget https://repo.almalinux.org/almalinux/9/synergy/x86_64/os/Packages/hxtools-20150304-19.el9.x86_64.rpm
yum install ./hxtools*
# gui veracrypt 
wget https://launchpad.net/veracrypt/trunk/1.26.24/+download/veracrypt-1.26.24-CentOS-8-x86_64.rpm
# console veracrypt
# wget https://launchpad.net/veracrypt/trunk/1.26.24/+download/veracrypt-console-1.26.24-CentOS-8-x86_64.rpm
yum install ./veracrypt*
yum install pam_mount cryptsetup
```

### Deb

```bash
# gui veracrypt
wget https://launchpad.net/veracrypt/trunk/1.26.24/+download/veracrypt_1.26.24-1_amd64.deb
# console veracrypt
# wget https://launchpad.net/veracrypt/trunk/1.26.24/+download/veracrypt-console_1.26.24-1_amd64.deb
apt install libpam-mount cryptsetup
```

## Edit configs

Three files need to be edited: 2 from pam.d and 1 from pam_mount

### Debian specific configs

In debian is inclusive configs in pam.d only 3 file will be changed automatically with setup of pam_mount, here is the list for information:

- common-auth `add auth   optional    pam_mount.so`
- common-password `password optional    pam_mount.so disable_interactive`
- common-session `session optional  pam_mount.so`

### RedHat specific configs

In RedHat for every auth method you need to edit each pam.d file. In this howto described only 2 auth methods/files

#### gdm-password

```bash
vim /etc/pam.d/gdm-password
```

```diff
auth     [success=done ignore=ignore default=bad] pam_selinux_permit.so
+auth       optional    pam_mount.so
password    required    pam_deny.so
+password   optional    pam_mount.so disable_interactive
session     include     postlogin
+session    optional    pam_mount.so
```

```bash
vim /etc/pam.d/sshd:
```

```diff
auth        include     postlogin
+auth       optional    pam_mount.so
account     include     password-auth
+password   optional    pam_mount.so disable_interactive
+session    optional    pam_mount.so
session     required    pam_selinux.so close
```

#### Common pam_mount config

```bash
vim /etc/security/pam_mount.conf.xml:
```

```diff
                <!-- Volume definitions -->
+<volume user="USER" fstype="crypt" path="/home/USER/vera" mountpoint="vera" />
+<volume user="USER" fstype="auto" path="/home/USER/vera" mountpoint="/mnt/vera" options="umask=077,uid=USER,gid=USER"/>
+<cryptmount>cryptsetup --type tcrypt open %(VOLUME) %(MNTPT)</cryptmount>
+<cryptumount>cryptsetup close %(MNTPT)</cryptumount>
+<umount>umount /mnt/vera</umount>
                <!-- pam_mount parameters: General tunables -->
```

## Container

### Make container

```bash
veracrypt -t -c --volume-type=Normal --size=100M --encryption=AES --hash=SHA-512 --filesystem=NTFS --password="PASSWORD" --pim=0 --random-source=/dev/urandom /home/USER/vera
```

### Test container

```bash
veracrypt --mount /home/USER/vera /mnt/vera
```

## Finish

reboot

connect to ssh with password:

```bash
ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no user@host
```

## SELinux

Create 2 new files in any folder for policy module

### Policy for ssh

```bash
vim  ssh_pammount.te 
```

Fill it following rules:

```vim
module ssh_pammount 1.0;

require {
    type sshd_t;
    type chkpwd_t;
    type lvm_exec_t;
    type shadow_t;
    type unconfined_t;
    class process { noatsecure rlimitinh siginh };
    class file { entrypoint read };
}

allow sshd_t chkpwd_t:process { noatsecure rlimitinh siginh };
allow sshd_t shadow_t:file read;
allow unconfined_t lvm_exec_t:file entrypoint;
```

Compile and install policy module:

```bash
checkmodule -M -m -o ssh_gdmmount.mod ssh_gdmmount.te
semodule_package -o ssh_gdmmount.pp -m ssh_gdmmount.mod
sudo semodule -i ssh_gdmmount.pp
```

### Policy for gdm

```bash
vim gdm_pammount.te
```

```vim
module gdm_pammount 1.0;

require {
    type xdm_t;
    type chkpwd_t;
    type lvm_control_t;
    type loop_control_device_t;
    type fixed_disk_device_t;
    type shadow_t;
    type user_home_t;
    type device_t;
    type dm_device_t;
    type policykit_t;
    
    class process { noatsecure siginh };
    class capability { sys_admin dac_override };
    class chr_file { ioctl read write open };
    class blk_file { ioctl read write open };
    class dir { search write };
    class file { read write create unlink getattr };
    class filesystem { mount };
}

allow xdm_t self:capability { sys_admin dac_override };
allow xdm_t chkpwd_t:process { noatsecure siginh };
allow xdm_t lvm_control_t:chr_file { ioctl read write open };
allowxperm xdm_t lvm_control_t:chr_file ioctl 0x0000fd00;
allow xdm_t loop_control_device_t:chr_file { ioctl read write open };
allowxperm xdm_t loop_control_device_t:chr_file ioctl 0x00004c82;
allow xdm_t fixed_disk_device_t:blk_file { ioctl read write open };
allowxperm xdm_t fixed_disk_device_t:blk_file ioctl 0x00004c0a;
allow xdm_t device_t:blk_file { read write };
allow xdm_t dm_device_t:blk_file { read write };
allow xdm_t shadow_t:file { read getattr };
allow xdm_t user_home_t:file { read write create unlink };
allow xdm_t user_home_t:dir { search write };
allow policykit_t xdm_t:process { siginh };
```

Compile and install policy module:

```bash
checkmodule -M -m -E -o gdm_pammount.mod gdm_pammount.te
semodule_package -o gdm_pammount.pp -m gdm_pammount.mod
sudo semodule -i gdm_pammount.pp
```

[Module with extra code plus comments](gdm_pammount.te)

### Checking SELinux log

```bash
tail -f /var/log/audit/audit.log | grep denied
```
