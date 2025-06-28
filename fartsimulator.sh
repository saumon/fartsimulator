#!/bin/bash

# A script that simulates farts using real MP3 sounds or macOS 'say' command fallback.
# Press Ctrl+C to stop.
# Usage: ./fartsimulator.sh [--no-mp3] [--help]

# Help function
show_help() {
    echo "💨 Fart Simulator 💨"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --no-mp3, -s    Force text-to-speech mode (ignore MP3 files)"
    echo "  --help, -h       Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0               # Normal mode (MP3 if available, otherwise text-to-speech)"
    echo "  $0 --no-mp3     # Force text-to-speech mode"
    echo "  $0 -s           # Same as --no-mp3"
    echo ""
    exit 0
}

# Check for command line arguments
FORCE_SAY=false
case "$1" in
    --help|-h)
        show_help
        ;;
    --no-mp3|-s)
        FORCE_SAY=true
        echo "🗣️ Forced text-to-speech mode enabled"
        ;;
    "")
        # No arguments, continue normally
        ;;
    *)
        echo "❌ Unknown argument: $1"
        echo "Use --help for usage information"
        exit 1
        ;;
esac

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOUNDS_DIR="$SCRIPT_DIR/sounds"

echo "Activating fart generator... Press Ctrl+C to quit."

# Check if sounds directory exists and has MP3 files (unless forced to use say)
if [[ "$FORCE_SAY" == false ]] && [[ -d "$SOUNDS_DIR" ]] && [[ $(find "$SOUNDS_DIR" -name "*.mp3" | wc -l) -gt 0 ]]; then
    echo "🔊 Using realistic MP3 fart sounds!"
    USE_MP3=true
    # Get all MP3 files in the sounds directory (compatible method)
    mp3_files=($(find "$SOUNDS_DIR" -name "*.mp3"))
else
    if [[ "$FORCE_SAY" == true ]]; then
        echo "🗣️ Using text-to-speech mode (forced by --no-mp3 flag)"
    else
        echo "🗣️ No MP3 files found, using text-to-speech fallback"
    fi
    USE_MP3=false
fi

# List of fun voices available on macOS
voices=("Bubbles" "Zarvox" "Trinoids" "Whisper" "Cellos" "Albert" "Bahh")

# List of fart sounds (onomatopoeia)
fart_sounds=("pfffft" "braaap" "plop" "tooooot" "prrrrt" "brap" "splat")

while true; do
    if [[ "$USE_MP3" == true ]]; then
        # Choose a random MP3 file
        num_mp3s=${#mp3_files[@]}
        random_mp3=${mp3_files[$((RANDOM % num_mp3s))]}

        # Play the MP3 file using afplay (built-in macOS audio player)
        afplay "$random_mp3" &
        echo "💨 $(basename "$random_mp3" .mp3)"

        # Wait longer for MP3 files to finish playing before next sound
        sleep_duration=$(echo "scale=2; $RANDOM/16384.0 + 2.0" | bc)
    else
        # Fallback to text-to-speech
        # Choose a random voice
        num_voices=${#voices[@]}
        random_voice=${voices[$((RANDOM % num_voices))]}

        # Choose a random fart sound
        num_sounds=${#fart_sounds[@]}
        random_sound=${fart_sounds[$((RANDOM % num_sounds))]}

        # "Say" the fart sound with the chosen voice
        say -v "$random_voice" "$random_sound"
        echo "💨 $random_sound"

        # Shorter wait for text-to-speech
        sleep_duration=$(echo "scale=2; $RANDOM/16384.0 + 0.5" | bc)
    fi

    # Wait a random time before the next sound
    sleep $sleep_duration
done
