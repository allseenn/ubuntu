# To disable X autostart on macbook pro with nvidia GPU.
1. MacBook has nvidia GPU onboard its driver must be blacklisted in file:
```
cd /etc/modprobe.d
echo "blacklist nvidia >> balcklist-nvidia.conf
echo "blacklist nvidia_uvm >> balcklist-nvidia.conf
```
2. In /etc/default/grub need to be set:
```
#first line with #nvidia.Nvreg..# enables Brighness contorl with F1 and F2 keys
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvidia.NVreg_RegistryDwords=EnableBrightnessControl=1"
GRUB_CMDLINE_LINUX="text"
GRUB_TERMINAL=console
```
save and update grub:
```
update-grub
```
3. Need to change system init level to 3:
```
systemctl set-default multi-user.target
```
4. Reboot
5. To start graphical desctop just exec:
```
startx
```
To restore descktop autostart just change init level with exec:
```
systemctl set-default graphical.target
```

