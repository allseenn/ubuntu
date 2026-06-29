# How to pair bluetooth device in console

## Turn bluetooth on

```
sudo systemctl start bluetooth
```

## Enter to bluetoothctl console

```bash
bluetoothctl
```

### Torn bluetooth adapter on

```[bluetooth]
power on
agent on
```

### Scan on

```[bluetooth]
scan on
```

### Pair device

```[bluetooth]
pair <MAC>
```

### Make device trusted

```[bluetooth]
trust <MAC>
```

### Connect device

```[bluetooth]
connect <MAC>
```

### List paired devices

```[bluetooth]
paired-devices
```

### Remove paired device

```[bluetooth]
remove <MAC>
```

## Troubleshooting

### lsusb

Most bluetooth adapters integrated with wifi on laptops have a USB interface. You could check it with command:

```bash
lsusb | grep -i bluetooth
```

```output
Bus 004 Device 003: ID 8087:0032 Intel Corp. AX210 Bluetooth
```

