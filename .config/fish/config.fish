if status is-interactive
    # Commands to run in interactive sessions can go here
  fish_add_path /home/berin/.local/bin
  starship init fish | source
  zoxide init fish | source
  fish_vi_key_bindings
  alias man="batman"
  alias cat="bat"
  alias ls="eza -a --color=always --group-directories-first --icons"
  alias lg="lazygit"
  alias tray="/home/berin/tray"
  alias hdmir="tmux attach-session -t right || tmux new -s right"
  alias r="tmux attach-session -t right || tmux new -s right"
  alias hdmil="tmux attach-session -t left || tmux new -s left"
  alias l="tmux attach-session -t left || tmux new -s left"
  alias main="tmux attach-session -t main || tmux new -s main"
  alias m="tmux attach-session -t main || tmux new -s main"
  alias tempo="curl 'wttr.in/~USP?2QF'"
  alias tempo2="curl 'v2.wttr.in/~USP?2QF'"
  alias tf='terraform'
  alias kb "/home/berin/keyboard-configure.sh"
  direnv hook fish | source
  set -gx EDITOR lvim
  set -gx BROWSER /usr/bin/firefox

  fish_add_path (go env GOPATH)/bin
  abbr -a ld lazydocker

  source /opt/asdf-vm/asdf.fish
  source ~/.asdf/plugins/golang/set-env.fish
  fnm env | source

  set -U -x RANGER_LOAD_DEFAULT_RC false
end
