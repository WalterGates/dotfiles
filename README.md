# dotfiles

WalterGates' dot files.

## Installation

You will need git and stow.
```
$ git clone https://github.com/WalterGates/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow */
```

## Install vscode extensions

Just run the scrip `./install-vscode-extensions.sh`.

Currently this relies on the `code` executable, so it isn't compatible with vscodium's `codium`.

## Arch specific

### Pacman color

Add or uncomment the line `Color` in the `[options]` section of `/etc/pacman.conf`.
```
[options]
Color
```

### Use `dash` as `/bin/sh`

To ensure that `bash` won't overrite `dash` when it updates, create a pacman hook to always change it back. Write the following to `/usr/share/libalpm/hooks/bash-update1.hook`:
```
[Trigger]
Type = Package
Operation = Install
Operation = Upgrade
Target = bash

[Action]
Description = Re-pointing /bin/sh symlink to dash...
When = PostTransaction
Exec = /usr/bin/ln -sfT dash /usr/bin/sh
Depends = dash
```

Afterwards you can either manually symlink `/bin/sh` to `dash`
```
$ sudo ln -sfT dash /usr/bin/sh
```
or just update or reinstall `bash` and the symlink will be created automatically.
```
$ sudo pacman -S bash
```
