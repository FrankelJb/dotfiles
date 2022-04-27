#!/bin/bash

nix-store --gc
nix-store --optimise
nix-collect-garbage -d
