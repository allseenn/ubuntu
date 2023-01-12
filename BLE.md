# How to pair same BLE devices with same PC with dual OSes boot
BLE - Bluetooth Low Energy mouse
PC -  Notebook x86 core i5
OSes - Windows 11 and Ubuntu 22.10
1. Pair mouse in ubuntu and reboot to windows
2. In windows pair mouse
3. Switch off mouse and reboot to ubuntu
4. In ubuntu via terminal:
```
apt-get install chntpw
```
5. Mount windows system drive or partition:
```
mount /dev/sdb1 /mnt
```
6. cd to windows regestry folder:
```
cd /mnt/Windows/System32/config
```
7. run regestry editor:
```
chntpw -e SYSTEM
```
8. go to bluetooth regestry branch:
```
cd \ControlSet001\Services\BTHPORT\Parameters\Keys
```
9. list your onboard bluetooth adaptors mac address:
```
ls
