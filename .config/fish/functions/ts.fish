function ts
    set raw $argv[1]
    set t (string trim -- "$raw")
    set t (string replace -ar -- '[^0-9]' '' "$t")

    if test -z "$t"
        echo "Usage: ts <timestamp seconds|milliseconds>"
        return 1
    end

    if not string match -qr -- '^[0-9]+$' "$t"
        echo "Could not parse timestamp from: $raw"
        return 1
    end

    # Detect milliseconds
    if test "$t" -gt 1000000000000
        set t (math -s0 "$t / 1000")
    end

    # Absolute times
    set local_str (date -d "@$t" "+%Y-%m-%d %H:%M:%S %Z")
    set utc_str (date -u -d "@$t" "+%Y-%m-%d %H:%M:%S UTC")

    # Relative time via python (no heredoc)
    set rel (python3 -c '
import sys, time, math
ts = int(sys.argv[1])
now = time.time()
diff = ts - now
absd = abs(diff)

def fmt(n, u):
    n = int(n)
    return f"{n} {u}" + ("" if n==1 else "s")

if absd < 90:
    core = fmt(round(absd), "second")
elif absd < 5400:
    core = fmt(round(absd/60), "minute")
elif absd < 129600:
    core = fmt(round(absd/3600), "hour")
elif absd < 1209600:
    core = fmt(round(absd/86400), "day")
elif absd < 7776000:
    core = fmt(round(absd/(7*86400)), "week")
elif absd < 47304000:
    core = fmt(round(absd/(30.44*86400)), "month")
else:
    core = fmt(round(absd/(365.25*86400)), "year")

if diff > 0:
    print("in " + core)
elif diff < 0:
    print(core + " ago")
else:
    print("now")
' "$t")

    echo "Local:    $local_str"
    echo "UTC:      $utc_str"
    echo "Relative: $rel"
end
