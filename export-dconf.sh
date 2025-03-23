#!/usr/bin/env bash

dconf dump / | dconf2nix >./hosts/desktop/dconf.nix
