# How to configure and check Fail2Ban

## Old OpenWRT

For proper work of Fail2Ban you need to have `rsyslog` installed on your router and `logd` shutdowned.

Fail2Ban for OpenWRT use `/var/log/secure` log file to monitor activity if it is not available fail2ban will not work.

```bash
fail2ban-client get dropbear logpath
```

response should be:

```console
Current monitored log file(s):
`- /var/log/secure
```

In `/etc/fail2ban/jail.conf` you could find list of all available log files (jails) and their configuration.

## Useful commands

Check if service is online from openwrt command line:

```bash
fail2ban-client ping
```

response should be:

```console
pong
```

List all available jails:

```bash
fail2ban-client status
```

response should be:

```console
Status
|- Number of jail:	1
`- Jail list:	dropbear
```

Status of specific jail:

```bash
fail2ban-client status dropbear
```

response should be:

```console
# fail2ban-client status dropbear
Status for the jail: dropbear
|- Filter
|  |- Currently failed:	0
|  |- Total failed:	2
|  `- File list:	/var/log/secure
`- Actions
   |- Currently banned:	2
   |- Total banned:	2
   `- Banned IP list:	5.24.75.111 31.173.85.111

```

Unban IP:

```bash
fail2ban-client set dropbear unbanip 5.24.75.111
```

Show ban time for specific jail:

```bash
fail2ban-client get dropbear bantime
```

Show max retries for specific jail:

```bash
fail2ban-client get dropbear maxretry
```
