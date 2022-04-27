## Requirements

- bat
- exa
- fd
- kitty
- nix
- xidlehook

## To use nix with fish step by step method that _just worked™_ for me

From a fish prompt on your macOS machine.

    1. `cd ~/.config/fish`

    2. `git clone git@github.com:oh-my-fish/plugin-foreign-env.git`

    3. Add the following lines to your `config.fish`($HOME/.config/fish/config.fish) to do 2 things:
       
       1. load the cloned repository functions so it can find `fenv`
       
       ```
       # include this plugin so nix will work
       # https://github.com/NixOS/nix/issues/1512
       # https://github.com/oh-my-fish/plugin-foreign-env
       set fish_function_path $fish_function_path $HOME/.config/fish/plugin-foreign-env/functions
       ```
       
       
       
       1. invoke `fenv` to source the `nix-daemon.sh`. You may need to adjust this path per what kind of install you have.
       
       ```
       # initialize nix
       fenv source '~/.nix-profile/etc/profile.d/nix.sh'
       ```

