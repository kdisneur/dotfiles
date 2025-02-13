# Dotfiles

Dotfiles are managed using [a Bare git repository](https://www.atlassian.com/git/tutorials/dotfiles).

## Setup

```
git clone --bare git@github.com:kdisneur/dotfiles $HOME/.dotfiles
```

## Usage

A `dotfiles` alias has been added to ease dotfiles management. It's just
an alias to `git` setup to point to the bare repository.

```
dotfiles status
dotfiles diff
dotfiles add <file>
dotfiles diff --cached
dotfiles commit -m "..."
dotfiles push
```
