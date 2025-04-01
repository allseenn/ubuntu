# How to open files GUI app from terminal with midnight commander

To open file by cliking on it or pressing Enter, like in Thunar explorer, you need to edit `~/.config/mc/mc.ext.ini ` file, and add to the end of it:

```
######### Default #########

# Default target for anything not described above
[Default]
Open="/usr/bin/xdg-open %f"
View=

### EOF ###
```
