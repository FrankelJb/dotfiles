{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    userSettings = {
      "editor.bracketPairColorization.enabled" = true;
      "editor.fontLigatures" = true;
      "editor.fontFamily" = "Fira Code";
      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;
      "editor.minimap.enabled" = false;
      "editor.wordWrap" = "on";
      "editor.lineNumbers" = "relative";
      "latex-workshop.latex.tools" = [{
          "name" = "latexmk";
          "command" = "latexmk";
          "args" = [
              "-xelatex"
              "-synctex=1"
              "-interaction=nonstopmode"
              "-file-line-error"
              "%DOC%"
          ];
      }];
      "redhat.telemetry.enabled" = false;
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
        dracula-theme.theme-dracula
        donjayamanne.githistory
        eamodio.gitlens
        gruntfuggly.todo-tree
        james-yu.latex-workshop
        matklad.rust-analyzer
        pkief.material-icon-theme
        redhat.vscode-yaml
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
