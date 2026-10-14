function mousebat --description 'Mostra modelo, bateria e status do mouse Logitech (hidpp)'
    for dev in /sys/class/power_supply/hidpp_battery_*
        echo (cat $dev/model_name)": "(cat $dev/capacity)"% ("(cat $dev/status)")"
    end
end
