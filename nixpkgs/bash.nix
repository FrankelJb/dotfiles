{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      if [ -f /etc/bashrc ]; then
      	. /etc/bashrc
      fi
      
      # User specific environment
      if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
      then
          PATH="$HOME/.local/bin:$HOME/bin:$PATH"
      fi
      export PATH
      
      # Uncomment the following line if you don't like systemctl's auto-paging feature:
      # export SYSTEMD_PAGER=
      
      # User specific aliases and functions
      if [ -d ~/.bashrc.d ]; then
      	for rc in ~/.bashrc.d/*; do
      		if [ -f "$rc" ]; then
      			. "$rc"
      		fi
      	done
      fi
      
      unset rc

      # export XDG_DATA_DIRS="/home/beans/.nix-profile/share/applications/:$XDG_DATA_DIRS"
      # if [ -e /home/beans/.nix-profile/etc/profile.d/nix.sh ]; then . /home/beans/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

      # source /usr/share/defaults/etc/profile
      # [ -f ~/.fzf.bash ] && source ~/.fzf.bash
      # . $HOME/.nix-profile/etc/profile.d/nix.sh
      # tmux attach -t 1 || tmux new -s 1
      # zellij attach || zellij
      # Source global definitions
    '';
    profileExtra = ''
      # PATH=$PATH:$HOME/.config/rofi/bin
      # source "/home/beans/.cargo/env"
      # export XDG_DATA_DIRS="/home/beans/.nix-profile/share/applications/:$XDG_DATA_DIRS"
      if [ -e /home/beans/.nix-profile/etc/profile.d/nix.sh ]; then . /home/beans/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
    '';
    sessionVariables = {
      SHELL="${pkgs.fish}/bin/fish";
    };
  };
}
