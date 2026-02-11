# How to install self-signed certificate on Android as system CA

## 1. generate self-signed PEM certificate

```bash
openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key squidCA.key -sha256 -days 3650 -out ca.crt
cat squidCA.key squidCA.crt > squidCA.pem
```

## 2. Rename properly the certificate

```bash
CA=$(openssl x509 -inform PEM -subject_hash_old -in ca.pem | head -1)
mv ca.pem $CA.0
```

## 3. Test certificate

```bash
openssl x509 -in /etc/squid/$CA.0 -text -noout
```

## 4. Copy to phone storage

```bash
adb push $CA.0 /sdcard/Downloads/
adb shell
ls /sdcard/Downloads/
```

## 5. Mount rw system

```bash
mount -o rw,remount /system
```

## 6. Install certificate

```bash
cp /sdcard/$CA.0 /system/etc/security/cacerts/
```

## 7. Reboot

```bash
reboot
```