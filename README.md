# dotfiles

This is my dotfiles repository to setup a new user account.
It contains any files needed to jump-start the user profile.

## Prerequisites

For the installation you really only need:

- GNU stow

But for all steps in the installation script to succeed you should also install:

- neovim
- tmux

For all neovim plugins to run you will need:

- java-environment
- nodejs
- npm
- rust
- go

## Install

For installation just clone the repository and run `install.sh <profile>`.
This will symlink any needed files to your home directory.  
After the first run you may run `install.sh` without any profile. The last profiles
selected are remembered.

**Attention: This is tested on Arch linux and macOS (Apple silicon) and may not work on other OSes**

## Profiles

A profile is a small shell script that provides a list of modules to install (see below)
and default applications. It can check prerequisites and handle platform specifics (e.g.
macOS and Linux specific modules for a use case)

## Modules

A module consists of the configuration files to be linked to $HOME and hooks to
be run pre-install/post-install.  
A hook is just an executable shell script.  
A module skeleton can be created with `create_module.sh MODULE_NAME`.
