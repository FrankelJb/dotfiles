{ config, pkgs, ... }:

let
  pkgsUnstable = import <nixpkgsUnstable> {};
in {

  home.packages = with pkgsUnstable; [
    zellij
  ];
}
