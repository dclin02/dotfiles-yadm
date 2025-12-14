#!/bin/sh
xrandr \
  --output eDP-1 --primary --rate 60 --mode 1920x1200 --rotate normal && \
# xrandr \
#   --output DisplayPort-1 --primary --rate 144 --mode 1920x1080 --rotate normal && \
  # --output DisplayPort-1 --primary --rate 144 --mode 1920x1080 --rotate normal \
  # --output HDMI-A-0 --mode 1920x1080 --left-of DisplayPort-1 --rotate left \
  # --output HDMI-A-1-1 --mode 1920x1080 --right-of DisplayPort-1 --rotate right
  sleep 1 && \
  xrandr \
    --output eDP-1 --mode 1920x1200 --rate 60 --pos 1457x1510 --rotate normal --scale 0.80x0.80 \
    --output HDMI-1 --primary --mode 2560x1440 --rate 120 --pos 1080x70 --rotate normal \
    --output DP-1 --rate 120 --mode 1920x1080 --pos 0x0 --rotate left \
    --output DP-3 --rate 75 --mode 1920x1080 --pos 3640x0 --rotate right
  # xrandr \
  #   --output DisplayPort-1 --primary --rate 240 --mode 2560x1440 --pos 1080x132 --rotate normal \
  #   --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate left \
  #   --output HDMI-A-1-1 --mode 1920x1080 --pos 3640x0 --rotate right
