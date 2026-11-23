function focus --description 'Foco da webcam C920: focus | focus auto | focus fixed [0-250]'
    set -l dev /dev/v4l/by-id/usb-046d_HD_Pro_Webcam_C920_F95B80DF-video-index0
    set -l default_value 50

    if not test -e $dev
        echo "focus: C920 não encontrada em $dev" >&2
        return 1
    end

    set -l mode $argv[1]
    if test -z "$mode"
        # Sem argumentos: alterna entre auto e fixo
        set -l current (v4l2-ctl -d $dev -C focus_automatic_continuous | string match -r '\d+$')
        if test "$current" = 1
            set mode fixed
        else
            set mode auto
        end
    end

    switch $mode
        case auto
            v4l2-ctl -d $dev -c focus_automatic_continuous=1; or return
            echo "foco: automático"
        case fixed
            set -l value $default_value
            if set -q argv[2]
                set value $argv[2]
            end
            if not string match -qr '^\d+$' -- $value; or test $value -gt 250
                echo "focus: valor deve ser um inteiro entre 0 e 250 (passos de 5)" >&2
                return 1
            end
            # Precisam ser chamadas separadas: a câmera recusa focus_absolute enquanto o autofoco está ligado
            v4l2-ctl -d $dev -c focus_automatic_continuous=0; or return
            v4l2-ctl -d $dev -c focus_absolute=$value; or return
            echo "foco: fixo em "(v4l2-ctl -d $dev -C focus_absolute | string match -r '\d+$')
        case '*'
            echo "uso: focus | focus auto | focus fixed [0-250]" >&2
            return 1
    end
end
