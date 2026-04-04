#!/usr/bin/env python3
"""
Sway dropdown terminal toggle.
Replaces i3drop.py: uses i3ipc (works with sway), app_id instead of instance,
and event subscription instead of append_layout + window swallowing.
"""
import i3ipc
import subprocess
import shlex

DROPDOWN_MARK   = "dropdown_alacritty_layout"
DROPDOWN_APP_ID = "dropdown_alacritty"
TERMINAL_COMMAND = (
    f"alacritty --class {DROPDOWN_APP_ID} "
    f"-e /usr/bin/fish -c 'tmux attach-session -t dropdown || tmux new -s dropdown'"
)
HEIGHT_PERCENTAGE = 50
WIDTH_PERCENTAGE  = 95


def build_toggle_command(sway):
    focused = sway.get_tree().find_focused()
    rect = focused.workspace().rect
    w = rect.width  * WIDTH_PERCENTAGE  // 100
    h = rect.height * HEIGHT_PERCENTAGE // 100
    x = rect.x + (rect.width * (100 - WIDTH_PERCENTAGE) // 200)
    y = rect.y
    return (
        f"[con_mark={DROPDOWN_MARK}] scratchpad show, "
        f"resize set {w} px {h} px, "
        f"move absolute position {x}px {y}px"
    )


sway = i3ipc.Connection()

# 1. Happy path: marked container already exists in scratchpad — toggle it.
toggle_cmd = build_toggle_command(sway)
replies = sway.command(toggle_cmd)
if all(r.success for r in replies):
    exit(0)

# 2. Config was reloaded and marks were lost: find the window by app_id and re-mark it.
existing = next(
    (n for n in sway.get_tree().leaves() if getattr(n, "app_id", None) == DROPDOWN_APP_ID),
    None,
)
if existing:
    sway.command(f"[con_id={existing.id}] mark --add {DROPDOWN_MARK}, move scratchpad")
    sway.command(build_toggle_command(sway))
    exit(0)

# 3. First run: launch the terminal, wait for the window to appear, then set it up.
def on_new_window(sway, event):
    if getattr(event.container, "app_id", None) == DROPDOWN_APP_ID:
        sway.command(
            f"[con_id={event.container.id}] "
            f"mark --add {DROPDOWN_MARK}, "
            f"floating enable, "
            f"move scratchpad"
        )
        sway.command(build_toggle_command(sway))
        sway.main_quit()

sway.on(i3ipc.Event.WINDOW_NEW, on_new_window)

subprocess.Popen(
    shlex.split(TERMINAL_COMMAND),
    shell=False, stdin=None, stdout=None, stderr=None, close_fds=True,
)

sway.main()
