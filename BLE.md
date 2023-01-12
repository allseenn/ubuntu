## How to pair same BLE devices with same PC with dual OSes boot
### Terms
- BLE - Bluetooth Low Energy mouse
- PC -  Notebook x86 core i5
- OSes - Windows 11 and Ubuntu 22.10
- IRK - IdentityResolvingKey
- LTK - LongTermKey
### Instruction
1. Pair mouse in ubuntu and reboot to windows
2. In windows pair mouse
3. Switch off mouse and reboot to ubuntu
4. In ubuntu via terminal:
```
# apt-get install chntpw
```
5. Mount windows system drive or partition (NTFS):
```
# mount /dev/sdb3 /mnt
```
6. cd to windows regestry folder:
```
# cd /mnt/Windows/System32/config
```
7. run regestry editor:
```
# chntpw -e SYSTEM
```
8. go to bluetooth regestry branch:
```
> cd \ControlSet001\Services\BTHPORT\Parameters\Keys
```
9. list your onboard bluetooth adaptors mac address:
```
(...)\Services\BTHPORT\Parameters\Keys> ls
Node has 1 subkeys and 0 values
  key name
  <ba1234567890>
```
Where <ba1234567890> is mac addrees of you onboard bluetooth adaptor without columns: BA:12:34:56:78:90
10. Dig and look to it <ba1234567890> with:
```
(...)\Services\BTHPORT\Parameters\Keys> cd ba1234567890
(...)\Services\BTHPORT\Parameters\Keys\ba1234567890> ls
Node has 1 subkeys and 1 values
  key name
  <be0011223344>
  size     type              value name             [value if type DWORD]
    16  3 REG_BINARY         <MasterIRK>
```
Where <be0011223344> is mac address of you mouse.
    
11. Dive to it <be0011223344>:
```
    (...)\BTHPORT\Parameters\Keys\ba1234567890> cd be0011223344

(...)\Parameters\Keys\ba1234567890\be0011223344> ls
Node has 0 subkeys and 9 values
  size     type              value name             [value if type DWORD]
    16  3 REG_BINARY         <LTK>
     4  4 REG_DWORD          <KeyLength>               16 [0x10]
     8  b REG_QWORD          <ERand>
     4  4 REG_DWORD          <EDIV>                 12345 [0xdc58]
    16  3 REG_BINARY         <IRK>
     8  b REG_QWORD          <Address>
     4  4 REG_DWORD          <AddressType>              1 [0x1]
     4  4 REG_DWORD          <MasterIRKStatus>          1 [0x1]
     4  4 REG_DWORD          <AuthReq>                 45 [0x2d]
```
12. Futher we copy to file or writedown on paper 4 parameter:
```
<LTK>
<ERand>
<EDIV>
<IRK>
```
13. With hex or cat command we open our LTK:
```
(...)\Parameters\Keys\ba1234567890\be0011223344> hex LTK
Value <LTK> of type REG_BINARY (3), data length 16 [0x10]
:00000  A7 23 17 D4 EF 34 30 7E 41 80 CE FE 0C 3B C5 90 .#...40~A....;..
```
Transform A7 23 17 D4 EF 34 30 7E 41 80 CE FE 0C 3B C5 90 to form withount spaces A72317D4EF34307E4180CEFE0C3BC590.
So, writedown to file with second terminal or your prefered editor:
```
$ echo "LTK A72317D4EF34307E4180CEFE0C3BC590" >> file
```
14. Get second one ERand
```
(...)\Parameters\Keys\ba1234567890\be0011223344> hex ERand
Value <ERand> of type REG_QWORD (b), data length 8 [0x8]
:00000  E8 2B 10 CB CF 81 BE 7F                         .+......
```
For value E8 2B 10 CB CF 81 BE 7F we make three transformations:
- make it reverse order 7F BE 81 CF CB 10 2B E8
- delete spaces 7FBE81CFCB102BE8
- transform it from hex to dec with any online converter or with terminal:
```
$ printf "%d\n" 0x7FBE81CFCB102BE8
9204937417856920552
```
Dont forget to put 0x before 7FBE81CFCB102BE8
```
$ echo "ERand 9204937417856920552" >> file
```
15. Third EDIV we just copy decimal value from regestri editor from [value if type DWORD] colomn, or make commands:
```
(...)\Parameters\Keys\ba1234567890\be0011223344> cat EDIV
Value <EDIV> of type REG_DWORD (4), data length 4 [0x4]
0x0000dc58
$ printf "%d\n" 0x0000dc58
56408
$ echo "EDIV 56408" >> file
```
16. Last parameter IRK to copy:
```
(...)\Parameters\Keys\ba1234567890\be0011223344> hex IRK
Value <IRK> of type REG_BINARY (3), data length 16 [0x10]
:00000  E6 9B 89 AE 47 4B 18 62 2B 1F A5 1E F4 3D BF 95 ....GK.b+....=..
```
In value E6 9B 89 AE 47 4B 18 62 2B 1F A5 1E F4 3D BF 95 delete spaces  E69B89AE474B18622B1FA51EF43DBF95
```
$ echo "IRK E69B89AE474B18622B1FA51EF43DBF95" >> file
```
17. So we have our 4 values in file:
```
$ cat file
LTK A72317D4EF34307E4180CEFE0C3BC590
ERand 9204937417856920552
EDIV 56408    
IRK E69B89AE474B18622B1FA51EF43DBF95
```
18. Go to linux bluetooth directore:
```
/var/lib/bluetooth/BA:12:34:56:78:90/BE:11:22:33:44:55
```
- Where dir BA:12:34:56:78:90 is mac address of our onboard bluetooth adapter
- And dir BE:11:22:33:44:55 is mac address of our mouse
19. edit info file in current directory:
```
# vim info
[General]
...
  
[ConnectionParameters]
...
  
[IdentityResolvingKey]
Key=E69B89AE474B18622B1FA51EF43DBF95

[LongTermKey]
Key=A72317D4EF34307E4180CEFE0C3BC590
Authenticated=0
EncSize=16
EDiv=56408
Rand=9204937417856920552

[PeripheralLongTermKey]
Key=A72317D4EF34307E4180CEFE0C3BC590
Authenticated=0
EncSize=16
EDiv=56408
Rand=9204937417856920552

[SlaveLongTermKey]
Key=A72317D4EF34307E4180CEFE0C3BC590
Authenticated=0
EncSize=16
EDiv=56408
Rand=9204937417856920552

[DeviceID]
...
```
As you could see info file contains many sectrions and each has several parameters, for us interesting sections is:
- [IdentityResolvingKey]
- [LongTermKey]
- [PeripheralLongTermKey]
- [SlaveLongTermKey]
20. from out parameter file copy LTK (Long Term Key) value A72317D4EF34307E4180CEFE0C3BC590
to Key parameter of three sections
- [LongTermKey]
- [PeripheralLongTermKey]
- [SlaveLongTermKey]
21. from file IRK (Identity Resolving Key) value E69B89AE474B18622B1FA51EF43DBF95 copy to Key parameter of [IdentityResolvingKey] section
22. from file EDIV value 56408 gous to EDiv parameters of three sections:
- [LongTermKey]
- [PeripheralLongTermKey]
- [SlaveLongTermKey]
23. from file ERand value 9204937417856920552 copy to Rand parameters in three sections:
- [LongTermKey]
- [PeripheralLongTermKey]
- [SlaveLongTermKey]
24. Save, Reboot and Swith On you mouse.
