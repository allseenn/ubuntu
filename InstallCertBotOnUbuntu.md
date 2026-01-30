# Install certbot on Ubuntu for nginx SSL certificates from Let's Encrypt

1. Intall certbot for nginx (alsa has for apache)

```bash
apt install python3-certbot-nginx
```

2. For first time setup, run the following command:

```bash
certbot run
```

And follow the instructions on the screen

3. Certbot agent install certificates from Let's Encrypt and make changes in nginx config files
Agent also install timer that will renew the certificates and wiil be checked twice a day.
To see the timer, run the following command:

```bash
systemctl status certbot.timer
```

To see all timer in you system, run the following command:

```bash
systemctl list-timers
```
