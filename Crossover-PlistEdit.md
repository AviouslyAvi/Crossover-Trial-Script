# Crossover Plist Edit

**Location:** `Projects/Crossover/Crossover Plist Edit/`
**Type:** macOS shell scripts + packaged `.dmg` installers
**Targets:** CodeWeavers **CrossOver** (Wine-based Windows-app runner) and the **PEAK Mouse Fix** for CrossOver users

---

## What it is

A collection of helper scripts and packaged installers around two related problems for **CrossOver on macOS**:

1. **Trial reset** — rewrite the `FirstRunDate` key in CrossOver's preferences plist so the trial clock resets. (Useful for testing; own a license for long-term use.)
2. **PEAK mouse fix** — a specific fix for running the game PEAK under CrossOver where the mouse behaves incorrectly.

There's also a `CrossoverRunManager.command` that wraps launching/managing CrossOver and PEAK with the fix applied.

## Beginner context

- **CrossOver** is a commercial Mac/Linux app from CodeWeavers built on top of Wine. It lets you run Windows apps and games without a full Windows VM.
- **Plist files** are macOS preference files (XML or binary). They live under `~/Library/Preferences/`. The `defaults` CLI reads/writes them.
- **`.command`** files are shell scripts Finder can double-click to run in Terminal.
- **`.dmg`** files are macOS disk images used as installers.

## Files

### Scripts

| File | Purpose |
|---|---|
| `reset_crossover_trial.sh` | Quits CrossOver if running, then sets `FirstRunDate` in `com.codeweavers.CrossOver` to today's UTC ISO-8601 time. |
| `inspect_crossover_plist.sh` | Reads CrossOver's plist so you can see current state. |
| `com.user.crossover-trial-reset.plist` | launchd agent — reset on a schedule. |
| `SETUP.command` | Bootstrap / install helper. |
| `CrossoverRunManager.command` / `Crossover_Run_Manager.command` | Launch CrossOver with the PEAK mouse fix applied. |
| `Build_DMGs.command` | Repackages the fix into the distributable `.dmg` files. |
| `push_to_github.command` | One-click publish helper. |

### Installers / distributables

| File | Purpose |
|---|---|
| `Crossover+Mouse Fix - Avious.dmg` / `Crossover+Mouse Fix.dmg` | Full CrossOver + PEAK mouse fix bundle (~380 MB). |
| `PEAK-Mouse-Fix.dmg` / `PEAK-Mouse-Fix-ReadOnly.dmg` | Mouse-fix-only installers. |
| `PEAK CrossOver Mouse Fix Guide.pdf` | User-facing instructions. |
| `CrossOver Trial Reset - README.pdf` | User-facing instructions for the reset script. |

## Using the trial reset

```bash
chmod +x reset_crossover_trial.sh
./reset_crossover_trial.sh
```

The script quits CrossOver (via AppleScript), verifies the plist exists at `~/Library/Preferences/com.codeweavers.CrossOver.plist`, then runs:

```bash
defaults write com.codeweavers.CrossOver FirstRunDate -date "$TODAY"
```

with `$TODAY` as the current UTC timestamp.

## Warnings

- Trial reset exists for legitimate testing/dev only. If you use CrossOver long-term, **buy a license** — CodeWeavers is a small shop.
- Always quit CrossOver before touching its plist; `defaults` caches preferences in memory while the app runs.
