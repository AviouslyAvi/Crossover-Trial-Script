# Crossover Trial Script

Helper shell scripts for **CodeWeavers CrossOver** on macOS. Two related concerns:

1. **Trial reset** — rewrite the `FirstRunDate` key in CrossOver's preferences plist so the trial clock resets.
2. **Bottle reset** — wipe a specific CrossOver bottle's state (used here for the Steam bottle running PEAK).

The scripts are double-clickable `.command` files; they run in `/bin/bash` directly from Finder.

## Files

| File | What it does | Usage doc |
|---|---|---|
| `Reset_CrossoverTrial.command` | Quits CrossOver, then writes `FirstRunDate` in `~/Library/Preferences/com.codeweavers.CrossOver.plist` to today's UTC ISO timestamp. | `Reset_RunManager_README.md` |
| `Reset_CrossoverBottle.command` | Resets the state of a specific CrossOver bottle. | `Reset_CrossoverBottle_README.md` |
| `Crossover-PlistEdit.md` | Long-form project overview (history, related installers, PEAK mouse fix context). | — |

## First-time setup

`.command` files need the executable bit before Finder will run them. From Terminal:

```bash
chmod +x Reset_CrossoverTrial.command
chmod +x Reset_CrossoverBottle.command
```

After that, double-click either file in Finder.

## Requirements

- macOS (tested on Apple Silicon).
- CodeWeavers **CrossOver** installed (plist path: `~/Library/Preferences/com.codeweavers.CrossOver.plist`).
- **Quit CrossOver before running** — the `defaults` system caches preferences in memory while the app is running and will overwrite your changes on quit.

## Ethics

Trial-reset scripts exist for legitimate testing and dev. For long-term CrossOver use, **buy a license** — CodeWeavers is a small shop and the product is worth paying for.

## For contributors / AI

See `CLAUDE.md` for the routing map and conventions used when editing this project.
