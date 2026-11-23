function nvc --wraps nvim --description "nvim com CPU limitada"
    systemd-run --user --scope --quiet --collect \
        -p CPUWeight=20 \
        -p CPUQuota=400% \
        -p MemoryHigh=8G \
        (command -s nvim) $argv
end
