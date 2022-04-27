{ config, pkgs, ... }:

let
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
    ./vscodium.nix
    ./unstable.nix
    ];

  home.packages = with pkgs; [
    # pkgs
    bat
    borgbackup
    bottom
    cryptomator
    czkawka
    delta
    drive
    exa
    fd
    fishPlugins.fzf-fish
    fslint
    fzf
    neovim
    nodejs
    rdfind
    ripgrep
    ouch
    sublime-music
    tmux
    ungoogled-chromium
    yarn
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
