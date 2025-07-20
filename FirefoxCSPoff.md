# How to switch off FireFox content security policy permanently

You could switch off FireFox content security policy till next update by following steps:

1. Open about:config
2. Search for "security.csp.enable"
3. Set the value to false

For permanent state you need to change file *user.js* in your *profile* directory:

1. To find your profile directory open *about:support* and press button **open folder** in **Profile folder** section
2. Open or create new file *user.js* in your *profile* directory, with following content:

```js
user_pref("security.csp.enable", false);
user_pref("security.csp.experimentalEnabled", false);
```