# Dotfiles

Dotfiles are managed using [rcm](https://github.com/thoughtbot/rcm).

Files at the root are installed everywhere. Files under `tag-<name>` are only
installed when that tag is active. `rcrc` (installed as `~/.rcrc`) picks the tag
from `uname`: `macos` on Darwin, `linux` on Linux.

Moving a file into a tag does not unlink it on machines where the tag is
inactive: delete the stale symlink by hand, or run `rcdn` before and `rcup`
after.

## Drop-in directories

Some configs are split so another dotfiles directory can add to them without
editing a file here. rcm merges every source into the same real directory, so
extra files just show up alongside these:

| Directory            | Loaded by                                        |
| -------------------- | ------------------------------------------------ |
| `zsh/rc.d/*.zsh`     | `zshrc`, sourced in alphabetical order            |
| `zsh/functions/*`    | `zshrc`, autoloaded                               |
| `config/nvim/lua/plugins/*.lua` | `init.lua`, each file is a lazy.nvim spec |
| `config/nvim/lua/rc/*.lua`      | `init.lua`, sourced in alphabetical order after the plugins |

## A second dotfiles directory

Machine-specific setups that do not belong here (work, ...) live in their own
repository and are added through an untracked `~/.rcrc.local`:

```sh
DOTFILES_DIRS="${DOTFILES_DIRS} ${HOME}/path/to/work-dotfiles";
TAGS="${TAGS} work";
```

That repository uses the same layout, under `tag-work/`. To add a neovim plugin
there, `tag-work/config/nvim/lua/plugins/whatever.lua` is enough — this repo
does not need to know about it.

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
