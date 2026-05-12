#!/bin/bash
# Reset CrossOver Steam Bottle - Double-click to run
# Removes the [Software\\CodeWeavers\\CrossOver\\cxoffice] block from system.reg
# so CrossOver re-evaluates install/nag/version state.

# Self-fix: ensure this script is executable
chmod +x "$0" 2>/dev/null

REG_FILE="$HOME/Library/Application Support/CrossOver/Bottles/Steam/system.reg"

echo "======================================="
echo "   CrossOver Steam Bottle Reset"
echo "======================================="
echo ""

# Ensure CrossOver is not running first
if pgrep -xq "CrossOver"; then
    echo "CrossOver is running. Quitting it now..."
    osascript -e 'quit app "CrossOver"' 2>/dev/null
    sleep 2
fi

# Kill any lingering CrossOver / Wine processes that keep the bottle busy
pkill -x "CrossOver" 2>/dev/null
pkill -f "CrossOver.app"  2>/dev/null
pkill -f "cxoffice"        2>/dev/null
pkill -f "wineserver"      2>/dev/null
pkill -f "wine64-preloader" 2>/dev/null
pkill -f "wine-preloader"   2>/dev/null
sleep 1

# Check reg file exists
if [ ! -f "$REG_FILE" ]; then
    echo "Error: system.reg not found at:"
    echo "  $REG_FILE"
    echo ""
    echo "Press any key to close..."
    read -n 1
    exit 1
fi

# Backup
BACKUP="${REG_FILE}.bak.$(date +%Y%m%d%H%M%S)"
cp "$REG_FILE" "$BACKUP"
echo "Backup saved to: $BACKUP"

# Remove the [Software\\CodeWeavers\\CrossOver\\cxoffice] section header
# plus the 4 lines that follow it (#time, InstallTime, NagTime, Version).
# awk skips the header line and the next 4 lines.
TMP_FILE="${REG_FILE}.tmp.$$"
awk '
    /^\[Software\\\\CodeWeavers\\\\CrossOver\\\\cxoffice\]/ {
        skip = 4
        next
    }
    skip > 0 {
        skip--
        next
    }
    { print }
' "$REG_FILE" > "$TMP_FILE"

if [ ! -s "$TMP_FILE" ]; then
    echo "Error: edit produced an empty file. Aborting; original untouched."
    rm -f "$TMP_FILE"
    echo ""
    echo "Press any key to close..."
    read -n 1
    exit 1
fi

# Verify the section is actually gone in the new file
if grep -q '^\[Software\\\\CodeWeavers\\\\CrossOver\\\\cxoffice\]' "$TMP_FILE"; then
    echo "Error: cxoffice section still present after edit. Aborting."
    rm -f "$TMP_FILE"
    echo ""
    echo "Press any key to close..."
    read -n 1
    exit 1
fi

mv "$TMP_FILE" "$REG_FILE"

echo ""
echo "Removed [Software\\\\CodeWeavers\\\\CrossOver\\\\cxoffice] and its 4 entries."
echo "You can now relaunch CrossOver."
echo ""
echo "Press any key to close..."
read -n 1
