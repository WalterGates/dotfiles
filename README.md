# dotfiles
WalterGates' dot files.

## Installation
You will need git and stow.
```
$ git clone https://github.com/WalterGates/dotfiles.git ~/.dotfiles
$ stow --target=~ --dir=~/.dotfiles */
```

## Install vscode extensions
Just run the scrip ```./install-vscode-extensions.sh```.

Currently this relies on the ```code``` executable, so it isn't compatible with vscodium's ```codium```.
