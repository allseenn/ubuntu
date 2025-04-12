# How to constrain you Dnsmasql server to populate only iPv4 addresses for specific domains

DNS servers and forwarders like Dnsmasq send you bunch of IPs for specific domains. But, for some reasons you need have only IPv4 addresses in DNS response:

1. Host with IPv4 have better ttl than ti IPv6 counterpart
2. Your internet provider blocked IPv6 for some domain but IPv4 is opened
3. On router you have foregin 6in4 service installed but you want introduce youself as local resident
4. Some sites dont work well with IPv6 and etc

In /etc/dnsmasq.conf you can specify domains that you want to have only IPv4 addresses in DNS response:

```dnsmasq.conf
server=/example.com/
address=/example.com/1.1.1.1 
```
Then restart dnsmasq daemon, for systemd service:

```bash
sudo systemctl restart dnsmasq
```

And for sysvinit service:

```bash
sudo /etc/init.d/dnsmasq restart
```

To flush DNS cache on local (clients) machine:

```bash
sudo resolvectl flush-caches
```

OR in case of NetworkManager we could delete DNS-server choice from it:

```bash
sudo ln -s /run/NetworkManager/resolv.conf /etc/resolv.conf
```
