#!/usr/bin/env python3
"""
Sway full-screen dropdown terminal toggle.
Replaces i3drop-fs.py: same approach as swdrop.py but full width and height.
"""
import i3ipc
import subprocess
import shlex

DROPDOWN_MARK    = "main_alacritty_layout"
DROPDOWN_APP_ID  = "main_alacritty"
TERMINAL_COMMAND = (
    f"alacritty --class {DROPDOWN_APP_ID} "
    f"-e /usr/bin/fish -c 'tmux attach-session -t main || tmux new -s main'"
)


def build_toggle_command(sway):
    focused = sway.get_tree().find_focused()
    rect = focused.workspace().rect
    return (
        f"[con_mark={DROPDOWN_MARK}] scratchpad show, "
        f"resize set {rect.width} px {rect.height} px, "
        f"move absolute position {rect.x}px {rect.y}px"
    )


sway = i3ipc.Connection()

# 1. Happy path: marked container already in scratchpad — toggle it.
toggle_cmd = build_toggle_command(sway)
replies = sway.command(toggle_cmd)
if all(r.success for r in replies):
    exit(0)

# 2. Marks lost after reload: find by app_id and re-mark.
existing = next(
    (n for n in sway.get_tree().leaves() if getattr(n, "app_id", None) == DROPDOWN_APP_ID),
    None,
)
if existing:
    sway.command(f"[con_id={existing.id}] mark --add {DROPDOWN_MARK}, move scratchpad")
    sway.command(build_toggle_command(sway))
    exit(0)

# 3. First run: launch and wait.
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
