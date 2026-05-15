## How to Remap Keys for Comfortable Vim Usage
This guide explains how to remap keys on a MacBook Pro with Ubuntu 20.04 installed.

When using Vim for coding, you would ideally employ touch typing with all ten fingers. However, this becomes challenging with modern keyboards, making it hard to maintain the proper hand position without strain.

Many people ask: Why are the main Vim keys (CTRL, ALT, ESC) placed in such inconvenient positions?

The reason is that the Vim editor and its predecessor, Vi, were developed for older keyboards with a different key layout:

<img src=https://vintagecomputer.ca/wp-content/uploads/2015/01/LSI-ADM3A-full-keyboard.jpg>

To prevent finger strain, you can remap the keyboard keys using the standard Ubuntu file located at /etc/default/keyboard. Modify the XKBOPTIONS value according to your preference. In my case, the option is:

```
XKBOPTIONS="grp:alt_shift_toggle,caps:ctrl:swapcamp"
```

For ReadHat use following command:

```bash
sudo localectl set-x11-keymap us,ru pc105 grp:alt_shift_toggle ctrl:swapcaps
```

**The table describes the hardware keys and their corresponding remapped counterparts along with the options**

<table>
<tr><th>Hardware key</th><th>Mapped key</th><th>Options</th></tr>
<tr><td>CapsLock</td><td>ESC</td><td>caps:escape_shifted_capslock</td></tr>
<tr><td>CapsLock + Shift</td><td>CapsLock</td><td>caps:escape_shifted_capslock</td></tr>
<tr><td>Ctrl</td><td>CMD</td><td>ctrl:swap_lwin_lctl</td></tr>
<tr><td>CMD</td><td>Ctrl</td><td>ctrl:swap_rwin_rctl</td></tr>
<tr><td>CMD+Shift</td><td>Layout</td><td>grp:alt_shift_toggle</td></tr>
<table>

**List all XKBOPTIONS keys presented in manual page:**

```
man xkeyboard-config
```
