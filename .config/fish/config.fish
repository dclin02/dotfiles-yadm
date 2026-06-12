if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_add_path /home/daniel.lin/.local/bin
    starship init fish | source
    zoxide init fish | source
    fish_vi_key_bindings
    alias man="batman"
    alias cat="bat"
    alias ls="eza -a --color=always --group-directories-first --icons"
    alias lg="lazygit"
    # alias tray="/home/daniel.lin/tray"
    alias hdmir="tmux attach-session -t right || tmux new -s right"
    alias r="tmux attach-session -t right || tmux new -s right"
    alias hdmil="tmux attach-session -t left || tmux new -s left"
    alias l="tmux attach-session -t left || tmux new -s left"
    alias main="tmux attach-session -t main || tmux new -s main"
    alias m="tmux attach-session -t main || tmux new -s main"
    alias tempo="curl 'wttr.in/~USP?2QF'"
    alias tempo2="curl 'v2.wttr.in/~USP?2QF'"
    alias tf='/home/daniel.lin/.asdf/installs/terraform/1.5.5/bin/terraform'
    # alias tf='terraform'
    alias kb "/home/daniel.lin/keyboard-configure.sh"
    alias daily "/home/daniel.lin/daily"
    alias daily2 "go run /home/daniel.lin/repos/teste/daily/main.go"
    alias obsidian "/home/daniel.lin/Applications/Obsidian/Obsidian-1.8.10.AppImage"
    # alias gt "gotestsum --format-hide-empty-pkg --format testdox"
    alias gt "gotestsum --format-hide-empty-pkg"
    alias gcst "gcloud sql generate-login-token | copyq 'add(input()); select(0)'"
    alias avim "NVIM_APPNAME=astronvim nvim"
    alias lvim nvim
    alias vim "nvim --clean"
    direnv hook fish | source
    set -gx EDITOR nvim
    set -gx BROWSER /usr/bin/firefox

    fish_add_path (go env GOPATH)/bin
    abbr -a ld lazydocker

    # source /opt/asdf-vm/asdf.fish
    # source ~/.asdf/plugins/golang/set-env.fish
    # fnm env | source

    set -U -x RANGER_LOAD_DEFAULT_RC false

    # The next line updates PATH for the Google Cloud SDK.
    if [ -f '/home/daniel.lin/google-cloud-sdk/path.fish.inc' ]
        . '/home/daniel.lin/google-cloud-sdk/path.fish.inc'
    end


    # ASDF configuration code
    # if test -z $ASDF_DATA_DIR
    #     set _asdf_shims "$HOME/.asdf/shims"
    # else
    #     set _asdf_shims "$ASDF_DATA_DIR/shims"
    # end

    # Do not use fish_add_path (added in Fish 3.2) because it
    # potentially changes the order of items in PATH
    # if not contains $_asdf_shims $PATH
    #     set -gx --prepend PATH $_asdf_shims
    # end
    # set --erase _asdf_shims
end

fish_add_path $HOME/.local/bin

# pnpm
set -gx PNPM_HOME "/home/daniel.lin/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
