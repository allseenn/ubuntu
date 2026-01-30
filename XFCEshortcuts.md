# How to export/import XFCE keyboard shortcuts

## Export to file

```bash
cp ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml /usr/local/sbin/
```

## Import from file

```bash
cp /usr/local/sbin/xfce4-keyboard-shortcuts.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
```

## Reboot PC

```bash
reboot
```

