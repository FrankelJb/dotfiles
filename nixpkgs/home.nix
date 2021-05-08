{ config, pkgs, ... }:

let
  pkgsUnstable = import <unstable> {};
  user = "beans";
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  home = {
    homeDirectory = "/home/${user}";
    username = user;
  };
  news.display = "silent";

  imports = [
    ./bash.nix
    ./fish.nix
    ./vscode.nix
    ];

  home.packages = with pkgsUnstable; with pkgs; [
    # pkgs
    bat
    exa
    fzf
    niv # Used to generate nix package information
    ripgrep
    # pkgsUnstable
    bottom
    delta
    fd
    fishPlugins.fzf-fish
  ];

  programs = {
    home-manager.enable = true;
    starship = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
