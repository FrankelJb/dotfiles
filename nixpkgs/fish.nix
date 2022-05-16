{ config, lib, pkgs, ... }:

let
    concatFileContents = with lib; with builtins;
        suffix: dir: strings.concatStringsSep "\n" (attrsets.mapAttrsToList (name: _: readFile (dir + "/${name}")) (readDir dir));
in
{
  programs.fish = { 
    enable = true;
    shellAliases = {
      pbcopy = "xsel --clipboard --input";
      pbpaste = "xsel --clipboard --output";
    };
    shellAbbrs = {
      cat = "bat";
      diff = "delta -s";
      less = "bat";
      l = "exa";
      ls = "exa";
      lll = "exa -la";
      pip = "pip3";
      # ssh = "kitty +kitten ssh";
      vim = "nvim";
    };
    interactiveShellInit = concatFileContents ".fish" ../fish/functions;
  };
}
