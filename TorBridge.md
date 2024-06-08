# How to setup standalone tor server (not tor-browser) to use obfs4 bridges


## Install tor and obfs4proxy

### Ubuntu

```bash
apt instll tor obfs4proxy
```

### RedHat

```bash
yum install tor
```

```bash
wget https://rpmfind.net/linux/opensuse/tumbleweed/repo/oss/x86_64/obfs4-0.0.13-1.14.x86_64.rpm
```

```bash
yum install ./obfs4-0.0.13-1.14.x86_64.rpm
```

## Get bridges paramas

Send email to address: bridges@torproject.org
With subject: get bridges

And you recive automatic response with one bridge.
Its recomended to use several bridges for relaible connections.

## Config settings

Edit /etc/tor/torrc

```bash
SocksPort 192.168.1.11:9050
SocksPolicy accept 192.168.1.0/24
SocksPolicy accept 127.0.0.1/8
Log notice file /var/log/tor/notices.log
ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy
UseBridges 1
Bridge obfs4 111.X.X.X:36236 22000000000000000000000000000000000000 cert=/mOPlkKKJ$SDFSDDFLKKJHLLLKIJKKLJL/JLKKLKJJHJHHJKHH iat-mode=0
Bridge obfs4 222.X.X.X:9002 37A00000000000000000000000000000000000 cert=LKJLlkjjlLKJLLJLkkjjkjklj/UjksdkfljkjUUUUUUU iat-mode=0
```

Edit /etc/tor/torsocks.conf

```bash
TorAddress 192.168.1.11
TorPort 9050
OnionAddrRange 127.42.42.0/24
SOCKS5Username USER
SOCKS5Password PASSWORD
AllowInbound 1
AllowOutboundLocalhost 2
```

## Restart tor and check it works

```
systectl restart tor
tail -f /var/log/tor/notices.log
```

Finaly make settings for you browser
