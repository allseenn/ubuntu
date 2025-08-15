# How to disable systemd-resolved to improve performance of DNS lookups and for less failures


Most modern Linux distributions now have systemd-resolved enabled by default. This is not good idea because systemd-resolved is a critical component of systemd and it's the most common way to disable it.

To disable it, run the following command:

```shell
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
rm /etc/resolv.conf
echo "nameserver 8.8.8.8" > /etc/resolv.conf
sudo systemctl restart NetworkManager
```

To re-enable it, run the following command:

```shell
sudo systemctl enable systemd-resolved
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo systemctl restart systemd-resolved
```


