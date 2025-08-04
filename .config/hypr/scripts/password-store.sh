#!/usr/bin/env sh

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh &
