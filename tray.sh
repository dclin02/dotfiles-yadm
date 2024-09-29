#!/bin/bash
comment_tray_output_line () { sed -i -e "s/^\(\s*\)\(tray_output $1\)/\1# \2/g" config ; }
uncomment_tray_output_line () { sed -i -e "s/^\(\s*\)# \(tray_output $1\)/\1\2/g" config ; }

if [ -z "$1" ]; then set "primary"; fi;
cd /home/berin/.config/i3

for output in "primary" "HDMI-A-0" "DisplayPort-1" "HDMI-A-1-1"; do
  # ${a,,} gets $a in lowercase
  if [[ "${output,,}" == "${1,,}"* ]]; then
    uncomment_tray_output_line "$output"
  else
    comment_tray_output_line "$output"
  fi
done

i3-msg reload
