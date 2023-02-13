# How to change Fn key bahavior
1. After apllying pacth you get F1...F12 without pressint Fn
```
# echo "options hid_apple fnmode=2" >> /etc/modprobe.d/hid_apple.conf
2. Trigger copying the configuration into the initramfs bootfile.
```
# update-initramfs -u -k all
```
3. Reboot
```
# reboot
```
