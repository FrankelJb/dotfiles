if status is-interactive
and not set -q TMUX
  set -g TMUX tmux new-session -d -s base
  eval $TMUX
  tmux attach-session -d -t base
end

# include this plugin so nix will work
# https://github.com/NixOS/nix/issues/1512
# https://github.com/oh-my-fish/plugin-foreign-env
set fish_function_path $fish_function_path $HOME/.config/fish/plugin-foreign-env/functions
# initialize nix
fenv source '~/.nix-profile/etc/profile.d/nix.sh'

if command -v exa > /dev/null
	abbr -a l "exa"
	abbr -a ls "exa"
	abbr -a ll "exa -l"
	abbr -a lll "exa -la"
else
	abbr -a l "ls"
	abbr -a ll "ls -l"
	abbr -a lll "ls -la"
end

if command -v bat > /dev/null
	abbr -a cat "bat"
	abbr -a less "bat"
end

if command -v nvim > /dev/null
  abbr -a vim "nvim"
end

set -x PATH $HOME/.cargo/bin $PATH

set -x GOPATH $HOME/projects/go
set -x PATH $GOPATH/bin $PATH
