#!/bin/sh
xrandr \
  --output DisplayPort-0 --primary --rate 240 --mode 2560x1440 --rotate normal && \
# xrandr \
#   --output DisplayPort-1 --primary --rate 144 --mode 1920x1080 --rotate normal && \
  # --output DisplayPort-1 --primary --rate 144 --mode 1920x1080 --rotate normal \
  # --output HDMI-A-0 --mode 1920x1080 --left-of DisplayPort-1 --rotate left \
  # --output HDMI-A-1-1 --mode 1920x1080 --right-of DisplayPort-1 --rotate right
  sleep 1 && \
  xrandr \
    --output DisplayPort-0 --primary --rate 240 --mode 2560x1440 --pos 1080x132 --rotate normal \
    --output DisplayPort-1 --mode 1920x1080 --rate 144 --pos 0x0 --rotate left \
    --output HDMI-A-0 --mode 1920x1080 --pos 3640x0 --rotate right
  # xrandr \
  #   --output DisplayPort-1 --primary --rate 240 --mode 2560x1440 --pos 1080x132 --rotate normal \
  #   --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate left \
  #   --output HDMI-A-1-1 --mode 1920x1080 --pos 3640x0 --rotate right
