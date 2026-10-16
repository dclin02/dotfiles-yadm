# Audio setup (Ubuntu 26.04, PipeWire 1.6)

Hardware: **Topping DX3 Pro+** (headphones and speakers, DAC) · **Husky Howl** (mic) · Bluetooth headsets.
EasyEffects runs on every output (EQ with a -12.6 dB preamp), and follows the system default output.

## Speaker calls: echo cancellation (on demand)

Only needed when the call audio comes out of the **speakers**. With headphones there is no echo, so leave it off.

```bash
systemctl --user start husky-aec   # before the call
systemctl --user stop  husky-aec   # after the call
```

In the call app:
- **Microphone:** `Husky Howl (AEC)` (echo cancellation + RNNoise + gate)
- **Speaker:** leave it on the default (DX3). Don't change the system default output or EasyEffects.

Check it is running: `systemctl --user is-active husky-aec`

**Why it isn't always on:** it listens to what the DX3 plays and links the DX3 to the Husky, which has a different clock, in 10 ms cycles.
Running all the time, that undid the Firefox fix and cut the audio in Meet and music. While it is on, small dropouts can happen, but in testing it sounded clean.

Measured (2026-10-16, music on the speakers): it removes about 23 dB of music, and the voice comes through about 16 dB above what is left.

Meet, Slack, Zoom and Discord also have their own echo cancellation. With the raw Husky mic or `Husky Howl (RNNoise)` that is usually enough.

Config: `~/.config/pipewire/husky-aec.conf` · service: `~/.config/systemd/user/husky-aec.service` (not enabled on purpose).

## Mics

| Mic | When to use it |
|---|---|
| `Husky Howl (RNNoise)` | Day to day, with headphones (noise removal + gate) |
| `Husky Howl (AEC)` | Speaker calls (only exists while `husky-aec` is running) |
| Raw Husky Howl | If the RNNoise gate cuts too much or interferes with the app's echo cancellation |

## Fixes that are already in place (don't undo)

| File | What it does |
|---|---|
| `~/.config/pipewire/pipewire-pulse.conf.d/20-firefox-latency.conf` | Firefox gets 21 ms audio blocks. Without it, Firefox's WebRTC (Meet) produced artifacts and delay; Chrome was fine. |
| `~/.config/wireplumber/wireplumber.conf.d/51-disable-suspension.conf` | Only the DX3, the Husky mic and Bluetooth never suspend (fixes sound in only one ear after resume). Keeping *every* device awake (HDMI, BTD 700, webcam...) delayed PipeWire and caused cuts. |
| `~/.config/pipewire/pipewire.conf.d/10-rates.conf` | The DX3 follows the music's rate (44.1 kHz on Spotify, no resampling). |
| `~/.config/pipewire/pipewire.conf.d/50-rnnoise.conf` | Creates `Husky Howl (RNNoise)`. |

Never put full copies of `pipewire.conf` / `client.conf` in `~/.config/pipewire/`. They override the system defaults on upgrades; use `*.conf.d/` add-on files instead.

## If the audio starts cutting

1. **Measure:** run `pw-top` and watch the **ERR** column (it shouldn't keep growing) and **QUANT** (1024 or more is good; 256 means something is forcing short cycles).
2. **Usual suspects:**
   - **pavucontrol open:** its meters keep every device running in 5 ms cycles. Close it (check with `pgrep pavucontrol`).
   - **Echo cancellation left on:** run `systemctl --user stop husky-aec`.
   - **Stuck `ssh-add` at 100% CPU:** check with `pgrep -c ssh-add`. That means the passphrase saved in the keyring no longer opens `~/.ssh/id_ed25519`; fix it in Seahorse ("Unlock password for: ...").
   - **Idle devices running:** in `pw-top`, HDMI or BTD 700 showing up with errors and nothing playing on them.
3. **Calls only in Firefox:** in `about:webrtc` → *Copy Report*, look at `removedSamplesForAcceleration` and `concealedSamples` on the audio `inbound-rtp`. If they grow with no packet loss, the problem is local.
4. **Restart the audio** (cuts all sound for a few seconds; don't do it during a call):
   ```bash
   systemctl --user restart pipewire pipewire-pulse wireplumber && systemctl --user restart easyeffects
   ```
   Then reload the Firefox tab if it goes silent.
