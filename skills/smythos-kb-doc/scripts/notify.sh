#!/bin/bash
# SmythOS KB Doc - Completion notification
# Plays pre-generated male voice: "Documentation complete. Ready for review."
# Cross-platform: Linux, macOS, Windows (Git Bash/WSL)

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AUDIO_FILE="$(dirname "$SCRIPT_DIR")/assets/kb-doc-complete.mp3"

if [ ! -f "$AUDIO_FILE" ]; then
    echo "Audio file not found: $AUDIO_FILE"
    exit 1
fi

OS="$(uname -s)"
case "$OS" in
    Darwin)
        # macOS
        afplay "$AUDIO_FILE" 2>/dev/null
        ;;
    Linux)
        # Linux - try players in order of preference
        if command -v gst-play-1.0 &>/dev/null; then
            gst-play-1.0 --no-interactive "$AUDIO_FILE" >/dev/null 2>&1
        elif command -v paplay &>/dev/null; then
            gst-launch-1.0 playbin uri="file://$AUDIO_FILE" >/dev/null 2>&1
        elif command -v mpv &>/dev/null; then
            mpv --no-video "$AUDIO_FILE" >/dev/null 2>&1
        elif command -v mpg123 &>/dev/null; then
            mpg123 -q "$AUDIO_FILE" 2>/dev/null
        else
            echo "No audio player found. Install gstreamer, mpv, or mpg123."
        fi
        ;;
    MINGW*|MSYS*|CYGWIN*)
        # Windows (Git Bash / MSYS2 / Cygwin)
        powershell.exe -c "(New-Object Media.SoundPlayer '$AUDIO_FILE').PlaySync()" 2>/dev/null \
            || cmd.exe /c "start /min wmplayer \"$AUDIO_FILE\"" 2>/dev/null
        ;;
    *)
        echo "Unsupported OS: $OS"
        ;;
esac
