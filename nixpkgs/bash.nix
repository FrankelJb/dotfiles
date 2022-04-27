{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # source /usr/share/defaults/etc/profile
      [ -f ~/.fzf.bash ] && source ~/.fzf.bash
      . $HOME/.nix-profile/etc/profile.d/nix.sh
      tmux attach -t 1 || tmux new -s 1
      # zellij attach || zellij
    '';
    profileExtra = ''
      source /usr/share/defaults/etc/profile
      PATH=$PATH:$HOME/.config/rofi/bin
      source "/home/beans/.cargo/env"
      export XDG_DATA_DIRS="/home/beans/.nix-profile/share/applications/:$XDG_DATA_DIRS"
      if [ -e /home/beans/.nix-profile/etc/profile.d/nix.sh ]; then . /home/beans/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
    '';
    sessionVariables = {
      SHELL="${pkgs.fish}/bin/fish";
    };
  };
}
