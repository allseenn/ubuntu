# Howto install last version of twrp with Debian (13) on xperia zl

Instruction will guide you through the process of installation of twrp with Debian (13) on Sony Xperia ZL (C6503)

1. download the latest version of twrp here https://dl.twrp.me/odin/ on Debian in the desired directory, for example /tmp
2. downloaded file will have a name like twrp-3.6.0_9-0-odin.img, place it in /tmp
3. At Debian console run:

```bash
apt install fastboot 
```

4. switch off the power of the phone. Do not touch the power button until the end of the flashing process.
6. find a working micro usb cable (check it with other devices)
7. connect the micro usb-A cable to PC, preferably directly without hubs and extenders, preferably from the back side of the motherboard.
8. Press the volume up key on the phone and do not release it. Do not touch the power button until the end of the flashing process.
9. Connect the Micro-usb cable to phone.
10. Light notifications blink red and switch to blue (the phone entered the flashing mode)
11. When lights turn blue, release the volume up key
12. On the PC, go to the directory with the downloaded twrp image /tmp and use the dmesg command to make sure that the device is visible, the output should be something like:

```bash
[ 3740.320395] usb 1-2: new high-speed USB device number 12 using ehci-pci
[ 3740.471497] usb 1-2: New USB device found, idVendor=0fce, idProduct=0dde, bcdDevice= 1.00
[ 3740.471506] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 3740.471508] usb 1-2: Product: S1Boot Fastboot
[ 3740.471510] usb 1-2: Manufacturer: Sony Mobile Communications AB
[ 3740.471512] usb 1-2: SerialNumber: EP123456PJ
```

13. Then run:

```bash
fastboot flash boot twrp-3.6.0_9-0-odin.img
```

14. If the PC console displays a success message not more than 2 seconds, the procedure is complete:

```bash
$ fastboot flash boot twrp-3.6.0_9-0-odin.img
Warning: skip copying boot image avb footer (boot partition size: 0, boot image size: 13629440).
Sending 'boot' (13310 KB)                          OKAY [  0.496s]
Writing 'boot'                                     OKAY [  0.643s]
Finished. Total time: 1.157s
```

15. If the installation process is to long, then wait for the error to appear, about a few minutes will be written the reason, for example not found device, then fix: change the cable, insert in another usb-port, read this instruction again
16. After successful update (installation) twrp disconnect the usb-cable from the phone
17. Switch on the power button of the phone and hold the volume up key until the logo appears
18. After successful update (installation) twrp disconnect the usb-cable from the phone

If you install firmware without embedded twrp, then you will need this instruction again )