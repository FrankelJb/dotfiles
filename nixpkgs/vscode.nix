{ pkgs, ... }:

{
  # home.packages = [
  #   vscodium-with-extensions
  # ];
  programs.vscode = {
    enable = true;

    package = pkgs.vscodium;
    userSettings = {
      "editor.fontLigatures" = true;
      "editor.fontFamily" = "Fira Code";
      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;
      "editor.minimap.enabled" = false;
      "editor.wordWrap" = "on";
      "rust.build_on_save" = true;
      "vim.sneak" = true;
      "vim.sneakUseIgnorecaseAndSmartcase" = true;
      "vim.easymotion" = true;
      "vim.camelCaseMotion.enable" = true;
      "vim.normalModeKeyBindings" = [
          {
              "before" = [
                  "leader"
                  "w"
              ];
              "commands" = [
                  "workbench.action.files.save"
              ];
          }
      ];
      "vim.leader" = "<space>";
      "workbench.colorTheme" = "Dracula";
      "workbench.iconTheme" = "material-icon-theme";
    };
    extensions = (with pkgs.vscode-extensions; [
        bbenoist.Nix
        coenraads.bracket-pair-colorizer-2
        dracula-theme.theme-dracula
        donjayamanne.githistory
        gruntfuggly.todo-tree
        james-yu.latex-workshop
        pkief.material-icon-theme
        matklad.rust-analyzer
        ms-python.python
        skyapps.fish-vscode
        tamasfe.even-better-toml
        vscodevim.vim
      ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "advanced-new-file";
        publisher = "patbenatar";
        version = "1.2.2";
        sha256 = "09a6yldbaz9d7gn9ywkqd96l3pkc0y30b6b02nv2qigli6aihm6g";
      }{
        name = "All-Autocomplete";
        publisher = "Atishay-Jain";
        version = "0.0.23";
        sha256 = "1ixvh3rrkfr6kvrnj7wvq0skwfjsh9whf4k1rm20wgcibfg1dpj6";
      }
    ];
  };
}
