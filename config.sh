#! /bin/bash

DOTFILES=(.bash_profile .gitconfig .gitignore .zshrc)

for dotfile in $(echo ${DOTFILES[*]});
do
    cp ~/nnthanh101/$(echo $dotfile) ~/$(echo $dotfile)
done
