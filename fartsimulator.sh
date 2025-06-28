#!/bin/bash

# A script that simulates farts using macOS 'say' command.
# Press Ctrl+C to stop.

echo "Activating fart generator... Press Ctrl+C to quit."

# List of fun voices available on macOS
voices=("Bubbles" "Zarvox" "Trinoids" "Whisper" "Cellos" "Albert" "Bahh")

# List of fart sounds (onomatopoeia)
fart_sounds=("pfffft" "braaap" "plop" "tooooot" "prrrrt" "brap" "splat")

while true; do
    # Choose a random voice
    num_voices=${#voices[@]}
    random_voice=${voices[$((RANDOM % num_voices))]}

    # Choose a random fart sound
    num_sounds=${#fart_sounds[@]}
    random_sound=${fart_sounds[$((RANDOM % num_sounds))]}

    # "Say" the fart sound with the chosen voice
    say -v "$random_voice" "$random_sound"
    echo "💨"

    # Wait a random short time before the next sound
    sleep_duration=$(echo "scale=2; $RANDOM/16384.0 + 0.5" | bc)
    sleep $sleep_duration
done
