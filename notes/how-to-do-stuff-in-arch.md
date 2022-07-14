# Installing Arch Linux
Follow the steps laid out on the Arch wiki. Parts of it are confusing, so I will list useful notes/explanations here:
# Sound/Audio
* get `pipewire`, `wireplumber`, and `alsa-utils`
* command for increasing/decreasing volume can be found in the man page for amixer:
* `amixer -c 0 set Master 10dB+` (nice that it works with decibels, right?)
## Pre-Installation
* When it comes to laptop/desktop computers, it's easiest to install from a flash drive (the alternative is partitioning the same disk to store the installation media and the installation)
* Flashing an ISO from Windows: don't use Balena Etcher. It seems bloated and untrustworthy. Use rufus instead.
* Flashing an ISO from Linux: easiest method is just to use the `dd` command
* Verify signatures, don't be lazy!
## Connect to the internet
* Some laptops don't have wifi, so make sure to use the iwctl utility (relevant syntax is on the Arch Wiki)
## Partition the disks
* MentalOutlaw's layout works, but so does the suggested UEFI layout on the wiki
* don't forget to `mkfs.ext4 /dev/root_partition` and `mkfs.fat -F 32 /dev/root_partition`
## Install essential packages
* `pacstrap /mnt base base-devel linux linux-firmware man-db networkmanager vim`
## Root password
* I forgot this once and I had to restart the whole install, don't forget this!
## Boot loader
* `grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB`
* `grub-mkconfig -o /boot/grub/grub.cfg`
* Make sure to enable the os prober in the config file: `/etc/default/grub`. This is essential!!! If you don't, your computer will boot into a grub shell at startup (at least for my UEFI laptop). From there, you will have to manually boot Arch. It's at least salvageable, but manually booting is obviously inconvenient.
# Xorg
## xorg-xinit
responsible for starting an x server (startx command), runs the xinitrc script  
* global script is /etc/X11/xinit/xinitrc
* local user script is ~/.xinitrc
## xorg-xsetroot
* sets the "xorg root", which translates to the status bar in DWM
## xorg-xset
* for setting "fast keys" (when you hold them down)
* use `xset r root <time> <speed>`
* a good time is 300 and a good speed is 100
## xorg-xprop
* for getting window properties with the `xprop` command
## xorg-xinput
* for the `xinput` command, really useful for finding input devices
## xbindkeys
* for setting keybinds (independent of DWM, but not Xorg)
* make a config file: `~/.xbindkeysrc`, then use xbindkeys -k to open a window that will get key info
* use that key info to associate commands with keys like so:
```
"amixer -c 0 set Master 10dB-"
  2    m:0x0 + c:123
```
* then use the `xbindkeys` command when you want to bind keys (including the .xinitrc config file)
# xsel
* Use this package instead of xclip. Easy clipboard access. Pipe stuff in to set the clipboard selection, type the command by itself to display the selection in stdout.
### Mouse Speed
* put this in .xinitrc: `xinput --set-prop 15 'libinput Accel Speed' 0.7`
# GPICK Color Picker
* easy GUI app for when you want to get colors from the screen
# DWM
* you need to install the relevant Xorg packages first
* after installing xorg-xinit, create/edit .xinitrc (should be in your home dir) to start DWM on startx. If confused about this step, refer to the DWM README (comes with the source)
* it won't run if you don't have a relevant font for config.h
* go to the ratfactor website if you ever forget the keybinds, but you can edit them in the source
# DMENU
* you can actually install it with pacman
* The `dmenu_run` script is executed by DWM. I have customized it so that it keeps a list of applications that should be run in the terminal/background (GUI).
# Alacritty
* config files at: `$XDG_CONFIG_HOME/alacritty/alacritty.yml`, `$XDG_CONFIG_HOME/alacritty.yml`, `$HOME/.config/alacritty/alacritty.yml`, or `$HOME/.alacritty.yml`
# VI/VIM
Softlink vi to the vim binary for convenience.  
Some useful settings for `.vimrc`  
* linebreak	-> like Word Wrap on Windows
* tabstop	-> amount of spaces in a tab
* syntax on/off	-> whether or not you want syntax highlighting
* Config file, .vimrc, is located in the user's home directory. Global config (default for sudo vi) is located at /etc/vimrc
## Useful commands to remember
* copy an entire line: `yy`
* paste the output of a command (useful with xsel): `:read !command`
## Pasting From the Clipboard
* `https://vim.fandom.com/wiki/GNU/Linux_clipboard_copy/paste_with_xclip`
* The best package for this is `xsel`. Install it and then bind to vim commands.
## Autocomplete (CoC)
* install vim-plug
* use vim-plug to install CoC vim plugin
* use :CocConfig to set up different language servers
* for c/c++:
```json
{
"languageserver": {
  "ccls": {
    "command": "ccls",
    "filetypes": ["c", "cc", "cpp", "c++", "objc", "objcpp"],
    "rootPatterns": [".ccls", "compile_commands.json", ".git/", ".hg/"],
    "initializationOptions": {
        "cache": {
          "directory": "/tmp/ccls"
        }
      }
  }
}
}
```
# TMUX
Useful when not running a gui and you want multiple terms
* go to tmuxcheatsheet.com and gist.github.com/MohamedAlaa/2961058 for default binds
* I'm trying to setup tmux to have the same layout and keybinds as DWM. Currently I have installed tpm (tmux plugin manager) from GitHub, and also the tmux-tilish plugin. However, I still need to configure some things.
# Provisioning New Users
* `useradd exampleuser`
* `passwd exampleuser`
## Enabling the wheel group
* `visudo`, and then uncomment the necessary lines
# Removing Root
* be careful not to do this unless you have sudo access already!
* `sudo usermod -L root` this locks the password (you can't login without making new password)
* for added security, in the `/etc/passwd` file, change the default shell for root to `/usr/sbin/nologin`, so that trying to login as root won't give a shell at all
# Bash
* global config file is `/etc/bash.bashrc`
* when writing a prompt, you MUST enclose non-printable characters in `\[` and `\]`, or else you will get the issue where text doesn't wrap properly. This mostly applies to ANSI escape sequences.
# Dash
* A faster shell than bash (POSIX compliant). You can softlink /bin/sh to /usr/bin/dash instead of the default bash for minor performance improvements.
* Be careful. Scripts that are not POSIX compliant won't run by default if you do this (without the handy little #!/usr/bin/bash line).
# Pacman
* refresh database: `pacman -Fy`
* search package databases for filename: `pacman -F filename`
* list all explicitly installed packages: `pacman -Qe`
* install package from an archive: `pacman -U file.tar.xz` (useful for AUR packages)
* remove package and its dependencies `pacman -Rcn` (shallow dependencies) `pacman -Rcns` (shallow and deep dependencies)
# Full Unicode Coverage in Terminal
* for testing, a good file is: https://antofthy.gitlab.io/info/data/utf8-demo.txt   probably won't be up forever, though.
* you can't actually get FULL coverage though (look at *Installing Fonts*)
# Brillo (Brightness)
* this utility is preferred to `xbacklight`, because it can scale brightness according to the way it is actually percieved by humans
* install it from the AUR, build it from source but make sure you get `md2man` first (it's just a markdown to man page utility)
* commands are very simple and intuitive, just look at the man page, then bind to keys
* By default, (on my current laptop's hardware), only root has access to the `brightness` device file, preventing me from executing brillo commands without sudo. So, I changed its group to video, and then allowed group write access. Be careful about those types of permissions, though!
# Installing Fonts
* put TTF's in `/usr/share/fonts/TTF`, BDF's in `/usr/share/fonts/BDF`, and so on...
* list all fonts and get official name of fonts with `fc-list`
* you can't get ALL the characters, because fonts can't store all that data, Nerd Fonts simply replace characters that you otherwise probably wouldn't use
# PipeWire
* When installing this, get `wireplumber`, as it's the better and more cutting-edge alternative to `pipewire-media-session`. It is being currently migrated to, so it will only get better in the future.
# FireFox
* the installation will ask for what packages you want. Select `pipewire-jack`, since pipewire is becoming the standard as opposed to the depreciated `pulseaudio`. Get `wireplumber` and `ttf-droid`.
## Configuring for Security (Hardened FF)
* look at the ArchWiki article
# LF
* You COULD build from source, but it's best to just get a binary, chmod it for execution, and then put it in `/usr/bin`.
# feh
* can be used to set the wallpaper AND view images, very powerful and simple
* read the ArchWiki
# Sudo logging
* systemd does this automatically, try `journalctl /usr/bin/sudo` 
# Journalctl (systemd logs)
* config file: `/etc/systemd/journald.conf`
# Clearing the Logs
* use `journalctl --rotate` and `journalctl --vacuum-time`
* `https://unix.stackexchange.com/questions/139513/how-to-clear-journalctl`
# ssh-keygen
* `ssh-keygen -t ed25519 -C eliotkimmelcentillion@gmail.com`
