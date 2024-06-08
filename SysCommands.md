# How to use useful system commands

## List of all services

```
systemctl list-units --type=service
```

## List of all running services

```
systemctl list-units --type=service --state=running
```

## List of all packages

```
dpkg -l
```
