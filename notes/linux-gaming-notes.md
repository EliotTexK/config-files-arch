# Razer Drivers
* install `python-setuptools`
* get the `openrazer` AUR package
* install `dkms` and `linux-headers`
* add your user to the `plugdev` group
* install `razercfg`
* edit `/etc/X11/xorg.conf` to disable the default mouse settings by commenting them out
* enable the `razerd` daemon
* reboot
* type `udevadm control --reload-rules
* build `openrazer`	with makepkg, then install `openrazer-driver`, `openrazer-daemon`, `python-openrazer`, and `openrazer-meta` in that order (pacman -U)
* According to the ArchWiki "the best way to interface with the drivers is with one of the following GUI frontends" and then lists a few. However, they suck. I think it would be better to eventually learn the API.
# Steam
* enable multilib by uncommenting a line in /etc/pacman.conf
* make sure to uncomment both lines:
```
[multilib]
Include = /etc/pacman.d/mirrorlist
```
* don't get steamcmd, because that's for steam devs and installing "dedicated servers" (Like TF2)
# No Audio With Steam Games
* you need the `pipewire-pulse` package
* Also, I was wrong about pipewire replacing pulseaudio. It seems like pipewire is a low-level lib whereas pulseaudio is a "sound server".
# DWM No Border
* Get the patch called `dwm-noborder`. It removes window borders when there is just one. This is useful because some native games won't run in fullscreen.
# Zen Kernel
* install `linux-zen`, `linux-zen-headers`
* in order for nvidia cards to work, you need to uninstall the default drivers `pacman -R nvidia` and install `nvidia-dkms`
* this unfortunately breaks graphics for the regular kernel, so if you want to go back you also need to switch out your driver packages again
