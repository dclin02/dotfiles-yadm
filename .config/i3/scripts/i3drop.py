#!/usr/bin/env python3
import i3ipc

# DROPDOWN_IDENTIFIER = "dropdown_wezterm_layout"
DROPDOWN_IDENTIFIER = "dropdown_alacritty_layout"
# DROPDOWN_CHILD_IDENTIFIER = "dropdown_wezterm"
DROPDOWN_CHILD_IDENTIFIER = "dropdown_alacritty"
INITIAL_TERMINAL_QUANTITY = 1
# TERMINAL_COMMAND = f"wezterm start --class {DROPDOWN_CHILD_IDENTIFIER} -- /usr/bin/fish -c '/home/berin/.config/i3/scripts/tmux-drop && tmux attach-session -t dropdown'"
TERMINAL_COMMAND = f"alacritty --class {DROPDOWN_CHILD_IDENTIFIER} -e /usr/bin/fish -c '/home/berin/.config/i3/scripts/tmux-drop && tmux attach-session -t dropdown'"
HEIGHT_PERCENTAGE = 50
WIDTH_PERCENTAGE = 95

i3 = i3ipc.Connection()
tree = i3.get_tree()
focused = tree.find_focused()
workspace_rect = focused.workspace().rect

toggle_dropdown_command = f"""
  [con_mark={DROPDOWN_IDENTIFIER}] scratchpad show,
  resize set {workspace_rect.width*WIDTH_PERCENTAGE//100} px {workspace_rect.height*HEIGHT_PERCENTAGE//100} px,
  move absolute position {workspace_rect.x + (workspace_rect.width*(100-WIDTH_PERCENTAGE)//200)}px {workspace_rect.y}px
"""

replies = i3.command(toggle_dropdown_command)

if all([r.success for r in replies]):
    exit(0)


# If we make it here, no container had the special dropdown mark.
# i3 resets marks if it gets reloaded, so search for container whose instance name is identifier
try:
    dropdown = tree.find_instanced(DROPDOWN_IDENTIFIER)[0].parent
    for r in i3.command(f"[con_id={dropdown.id}] mark --add {DROPDOWN_IDENTIFIER}"):
        print(r.error)
    print("found instance")

except IndexError:

    # Last resort, spawn a new dropdown container with our terminals

    import subprocess
    import shlex
    import json
    import tempfile

    def terminal():  # Launch a background terminal process
        subprocess.Popen(
            shlex.split(TERMINAL_COMMAND),
            shell=False,
            stdin=None,
            stdout=None,
            stderr=None,
            close_fds=True,
        )

    terminal_placeholder = {
        "border": "pixel",
        "layout": "splith",
        "current_border_width": 1,
        "floating": "auto_off",
        "percent": 0.30,
        "swallows": [{"instance": DROPDOWN_CHILD_IDENTIFIER}],
    }

    swallowable_layout = {
        "border": "none",
        "floating": "auto_off",
        "layout": "splith",
        "type": "con",
        "name": DROPDOWN_IDENTIFIER,
        "instance": DROPDOWN_IDENTIFIER,
        "marks": [DROPDOWN_IDENTIFIER],
        "nodes": [terminal_placeholder] * INITIAL_TERMINAL_QUANTITY,
    }

    with tempfile.NamedTemporaryFile("w", delete=True) as f:
        f.write(json.dumps(swallowable_layout))
        f.flush()
        i3.command(f"append_layout {f.name}")
    i3.command(f"[con_mark={DROPDOWN_IDENTIFIER}] move scratchpad")
    for i in range(INITIAL_TERMINAL_QUANTITY):
        terminal()

finally:
    i3.command(toggle_dropdown_command)
