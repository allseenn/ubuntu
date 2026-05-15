# How to install LAMP

Linux Apache (Nginx) MySQL and PHP

## Redhat with SElinux and Nginx

### Install packages

```sh
yum install nginx-all-modules php-fpm php-cli php-mysqlnd mysql-server
```

### create and edit conf file for virtual host

/etc/nginx/conf.d/example.com.conf:

```bash
    server {
    server_name example.com;
    listen 80;
    root         /mnt/backup/github/example.com;
    index index.php index.html index.htm;

	location / {
	index  index.php index.html index.htm;
	try_files $uri $uri/ /index.php?$args;
	}


	location ~ \.php(/|$) {
	fastcgi_pass unix:/run/php-fpm/www.sock;
	fastcgi_index index.php;
	include fastcgi_params;
	fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
	}

    error_page 404 /404.html;
    location = /404.html {
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
    }

}
```


### SELinux

#### Allow for FUSE file system

```bash
sudo semanage fcontext -a -t httpd_sys_content_t "/mnt/backup/github(/.*)?"
sudo restorecon -Rv /mnt/backup/github
```

##### User policy for nginx

```bash
sudo grep nginx /var/log/audit/audit.log | audit2allow -M mynginxpolicy
sudo semodule -i mynginxpolicy.pp
```

### Start services

```bash
systemctl enable php-fpm
systemctl start php-fpm
systemctl enable nginx
systemctl start nginx
sudo systemctl enable mysqld
sudo systemctl start mysqld
```

### Mysql user and base

```bash
mysql -u root

CREATE USER 'user'@'%' IDENTIFIED BY 'PASSWORD';
CREATE DATABASE base;
GRANT ALL PRIVILEGES ON base.* TO 'user'@'%';
FLUSH PRIVILEGES;
EXIT

mysql -u user -p
```
