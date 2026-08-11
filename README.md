# Dotfiles

Dotfiles are managed using [rcm](https://github.com/thoughtbot/rcm).

Files at the root are installed everywhere. Files under `tag-<name>` are only
installed when that tag is active. `rcrc` (installed as `~/.rcrc`) picks the tag
from `uname`: `macos` on Darwin, `linux` on Linux.

Moving a file into a tag does not unlink it on machines where the tag is
inactive: delete the stale symlink by hand, or run `rcdn` before and `rcup`
after.

## Setup

```
git clone git@github.com:kdisneur/dotfiles ~/Workspaces/github.com/kdisneur/dotfiles
ln -s ~/Workspaces/github.com/kdisneur/dotfiles/rcrc ~/.rcrc
rcup
```

The `~/.rcrc` symlink bootstraps the first run; `rcup` takes it over afterwards.

## Usage

```
rcup                      # install/refresh everything for this machine
mkrc ~/.config/foo/bar    # track a new file (all machines)
mkrc -t macos ~/.config/foo/bar  # track a new file (macOS only)
lsrc                      # list what would be installed
rcdn                      # remove the symlinks
```
