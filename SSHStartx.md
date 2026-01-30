# How to start X server remotly by ssh

Create /etc/X11/Xwrapper.config

```
allowed_users=anybody
```

Start X server

```
DISPLAY=:0 startx &
```

