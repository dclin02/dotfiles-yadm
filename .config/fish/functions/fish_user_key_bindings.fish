function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

bind ! __history_previous_command
bind '$' __history_previous_command_arguments
bind -M insert ! __history_previous_command
bind -M insert '$' __history_previous_command_arguments
