# Crossover Trial Script — Router

Helper shell scripts (`.command`) for CodeWeavers CrossOver on macOS. Two related concerns:
1. Reset CrossOver's trial clock by rewriting `FirstRunDate` in its plist.
2. Run-manager helper for launching CrossOver with the PEAK game's mouse fix applied.

This is a small project — single flat folder, no rooms needed.

## Folder map

| File | Purpose |
|---|---|
| `Reset_CrossoverTrial.command` | Quits CrossOver, rewrites `FirstRunDate` to today's UTC ISO timestamp. |
| `Reset_CrossoverBottle.command` | Resets a specific CrossOver bottle's state. |
| `Reset_CrossoverBottle_README.md` | Bottle-reset usage notes. |
| `Reset_RunManager_README.md` | RunManager usage notes. |
| `Crossover-PlistEdit.md` | Overview of the whole project (the closest thing to a project README). |

## Conventions

- `.command` files are double-clickable in Finder. They run in `/bin/bash`.
- The plist lives at `~/Library/Preferences/com.codeweavers.CrossOver.plist`.
- Always quit CrossOver before mutating its plist (`defaults` caches in memory while the app runs).

## Ethical note

Trial-reset is for legitimate testing/dev. For long-term CrossOver use, buy a license — CodeWeavers is a small shop.

## Task → file

| Task | Go to |
|---|---|
| Modify trial-reset behavior | `Reset_CrossoverTrial.command` |
| Modify bottle reset | `Reset_CrossoverBottle.command` |
| Understand the whole project | `Crossover-PlistEdit.md` |
