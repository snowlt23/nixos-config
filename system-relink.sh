#!/bin/sh

unlink /etc/nixos/configuration.nix
ln -sr ./configuration.nix /etc/nixos/configuration.nix
