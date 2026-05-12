#!/bin/bash
# Reset CrossOver Trial - Double-click to run
# Resets the CrossOver trial by updating FirstRunDate to today's date.

# Self-fix: ensure this script is executable
chmod +x "$0" 2>/dev/null

PLIST_FILE="$HOME/Library/Preferences/com.codeweavers.CrossOver.plist"

echo "======================================="
echo "   CrossOver Trial Reset"
echo "======================================="
echo ""

# Ensure CrossOver is not running
if pgrep -xq "CrossOver"; then
    echo "CrossOver is running. Quitting it now..."
    osascript -e 'quit app "CrossOver"'
    sleep 2
fi

# Kill the preferences cache daemon so writes go through cleanly
killall cfprefsd 2>/dev/null
sleep 1

# Check plist exists
if [ ! -f "$PLIST_FILE" ]; then
    echo "Error: Plist file not found at $PLIST_FILE"
    echo ""
    echo "Press any key to close..."
    read -n 1
    exit 1
fi

# Get today's date
TODAY=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Update the FirstRunDate key
defaults write com.codeweavers.CrossOver FirstRunDate -date "$TODAY"

# Force the preferences system to re-read from disk
killall cfprefsd 2>/dev/null

# Verify the write actually took effect
VERIFY=$(defaults read com.codeweavers.CrossOver FirstRunDate 2>/dev/null)
echo ""
if [ -n "$VERIFY" ]; then
    echo "FirstRunDate has been set to: $TODAY"
    echo "Verified value: $VERIFY"
else
    echo "WARNING: Write may not have taken effect."
    echo "Try running this from Terminal instead."
fi

echo ""
echo "You can now relaunch CrossOver."
echo ""
echo "Press any key to close..."
read -n 1
