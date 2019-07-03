#! /usr/bin/env bash

if [[ ! -d ~/Workspace/JakeBecker/elixir-ls ]]; then
  mkdir -p ~/Workspace/JakeBecker/;
  pushd ~/Workspace/JakeBecker/;
  git clone git@github.com:JakeBecker/elixir-ls.git;
  pushd elixir-ls
  mix local.hex --force;
  mix local.rebar --force;
  mix deps.get && mix compile;
  mix elixir_ls.release -o rel;
  popd;
  popd;
fi
