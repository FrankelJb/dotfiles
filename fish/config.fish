# if status is-interactive
# and not set -q TMUX
#   # set -g TMUX tmux new-session -d -s base
#   # eval $TMUX
#   tmux new -s base
# else if status is-interactive
#   tmux new
# end

if status --is-interactive
and not set -q TMUX
  exec tmux
end


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

if command -v pip3 > /dev/null
  abbr -a pip "pip3"
end

set -x PATH $HOME/.cargo/bin $PATH

set -x GOPATH $HOME/projects/go
set -x PATH $GOPATH/bin $PATH

set -x PATH $HOME/.local/bin $PATH

# Google Cloud environment variables
set -x PROJECT_ID simple-site-287918
set -x BUCKET_ID simple-site-287918.appspot.com

if command -v yarn > /dev/null
  set -x PATH (yarn global bin) $PATH
end

if test -e ~/.cargo-target
	setenv CARGO_TARGET_DIR ~/.cargo-target
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/beans/storage/google-cloud-sdk/path.fish.inc' ]; . '/home/beans/storage/google-cloud-sdk/path.fish.inc'; end

# Starship
starship init fish | source
