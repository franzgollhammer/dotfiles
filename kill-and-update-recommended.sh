#!/bin/bash

echo "== Schritt 1: Laufende Apps schließen =="

# Liste typischer GUI-Apps, die Updates blockieren können
apps=(
  "Safari"
  "SafariQuickLookPreview"
  "Google Chrome"
  "Firefox"
  "Preview"
  "TextEdit"
  "Mail"
  "Pages"
  "Numbers"
  "Keynote"
  "Xcode"
  "AnyDesk"
  "Activity Monitor"
  "Terminal"
  "System Settings"
  "System Preferences"
)

echo "→ Versuche, Apps sauber zu beenden (SIGTERM)..."
for app in "${apps[@]}"; do
  pkill -15 -x "$app" 2>/dev/null || true
done

# kurz warten, damit sie sich ordentlich schließen können
sleep 5

echo "→ Erzwinge Beenden verbleibender Apps (SIGKILL)..."
for app in "${apps[@]}"; do
  pkill -9 -x "$app" 2>/dev/null || true
done

echo "== Schritt 2: macOS-Updates ausführen =="

# Alle empfohlenen Updates installieren, inkl. Systemupdates
# KEIN sudo nötig, wenn ARD den Befehl als root ausführt
softwareupdate -ira --verbose
status=$?

echo "softwareupdate beendet mit Exit-Code: $status"

# Optional: Automat. Neustart nach dem Update
# ACHTUNG: entkommentieren, wenn du das wirklich willst.
#if [ $status -eq 0 ]; then
#  echo "→ Starte System neu..."
#  /sbin/shutdown -r now
#fi

echo "Fertig."
