# How to grand access for selinux to `.ssh` folder

Some times with RHEL updates selinux and some policies could be changed or set to defaults as result you could't get access to you ssh-server by keys from you ssh-clients.

If you have file system deffer then native linux even with proper permissions on files in the .ssh folder you could have the error:

```error
# journalctl -u sshd -f
june 25 08:49:01 red sshd-session[11494]: Could not open user 'user1' authorized keys '/home/user1/.ssh/authorized_keys': Permission denied
june 25 08:49:02 red sshd-session[11494]: Connection closed by authenticating user user1 ::1 port 54388 [preauth]
```

Make new file with rules [RHEL_SSH_authorized_keys.te](./RHEL_SSH_authorized_keys.te):

```te
module rhel_ssh_fix 1.0;

require {
	type sshd_t;
	type dosfs_t;
	type mount_var_run_t;
	class file { getattr open read };
}

#============= sshd_t ==============
allow sshd_t dosfs_t:file { getattr open read };
allow sshd_t mount_var_run_t:file { open read };
```

Temporary switch off selinux:

```bash
setenforce 0
```

Load new rules:

```bash
semodule -i RHEL_SSH_authorized_keys.pp 
```

Switch back selinux:

```bash
setenforce 1
```
