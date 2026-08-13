# Dotfiles

Dotfiles are managed using [rcm](https://github.com/thoughtbot/rcm).

Files at the root are installed everywhere. Files under `tag-<name>` are only
installed when that tag is active. `rcrc` (installed as `~/.rcrc`) activates two
tags:

- the OS, from `uname`: `macos` on Darwin, `linux` on Linux
- the location: `home` by default, `work` when `~/.rcrc.local` says so

Moving a file into a tag does not unlink it on machines where the tag is
inactive: delete the stale symlink by hand, or run `rcdn` before and `rcup`
after.

## Drop-in directories

Some configs are split so another dotfiles directory can add to them without
editing a file here. rcm merges every source into the same real directory, so
extra files just show up alongside these:

| Directory                              | Loaded by                                                            |
| -------------------------------------- | -------------------------------------------------------------------- |
| `profile.d/*.sh`                       | `profile`, sourced before `PATH` is exported so a fragment can extend it |
| `zsh/rc.d/*.zsh`                       | `zshrc`, sourced in alphabetical order                               |
| `zsh/functions/*`                      | `zshrc`, autoloaded                                                  |
| `config/nvim/lua/plugins/*.lua`        | `init.lua`, each file is a lazy.nvim spec                            |
| `config/nvim/lua/rc/*.lua`             | `init.lua`, sourced in alphabetical order after the plugins          |
| `config/update-system/update.d/*.sh`   | `update-system`, executed in alphabetical order                      |
| `ssh/config.d/*.conf`                  | `ssh/config`, source in alphabetical order                           |

## A second dotfiles directory

Machine-specific setups that do not belong here (work, ...) live in their own
repository and are added through an untracked `~/.rcrc.local`:

```sh
LOCATION="work";
DOTFILES_DIRS="${DOTFILES_DIRS} ${HOME}/path/to/work-dotfiles";
```

That repository uses the same layout, under `tag-work/`. To add a neovim plugin
there, `tag-work/config/nvim/lua/plugins/whatever.lua` is enough — this repo
does not need to know about it.

## Override files

Configs that are a single file cannot be merged by rcm, so they read an override
instead. These are not drop-ins: the second dotfiles directory ships the whole
file.

| File                       | Overrides                                        |
| -------------------------- | ------------------------------------------------ |
| `~/.rcrc.local`            | `rcrc`, sourced before the tags are computed so it can set `LOCATION` and add `DOTFILES_DIRS` |
| `~/.config/git/config.local` | `gitconfig`, included **last** so it can override anything, identity included |

Git applies an include where it appears, so the include has to stay at the end
of `gitconfig`: one placed earlier would lose to the `[user]` block above it. A
missing path is ignored silently, so this is safe on machines without an
override.

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
