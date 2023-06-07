# dotfiles

WalterGates' dot files.

## Installation

You will need `git` and `stow`.
```sh
git clone https://github.com/WalterGates/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow */
```

## Install vscode extensions

Just run the scrip. For `vscode` use `./install-vscode-extensions.sh` and for `vscodium` use `./install-vscodium-extensions.sh`.

## Arch specific

### Pacman settings

Add or uncomment the following lines in the `[options]` section of `/etc/pacman.conf`:
- `Color` for colored output.
- `ParallelDownloads = 10` for enabling parallel downloads. If you are on weaker hardware or your
internet connection isn't that good, consider lowering this number.

```
[options]
Color
```

### Use `dash` as `/bin/sh`

To ensure that `bash` won't overrite `dash` as `/bin/sh` when it updates, create a pacman hook to always change it
back. Write the following to `/usr/share/libalpm/hooks/bash-update1.hook`:
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
```sh
sudo ln -sfT dash /usr/bin/sh
```
or easier just update or reinstall `bash` and the symlink will be created automatically.
```sh
sudo pacman -S bash
```
