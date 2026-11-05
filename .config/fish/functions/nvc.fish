function nvc --wraps nvim --description "nvim com CPU limitada para calls"
    systemd-run --user --scope --quiet --collect \
        -p CPUWeight=20 \
        -p CPUQuota=400% \
        -p MemoryHigh=8G \
        env NVIM_CALL=1 (command -s nvim) $argv
end
