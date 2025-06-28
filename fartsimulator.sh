#!/bin/bash

# Un script qui simule des pets en utilisant la commande 'say' de macOS.
# Appuyez sur Ctrl+C pour arrêter.

echo "Activation du générateur de pets... Appuyez sur Ctrl+C pour quitter."

# Liste des voix amusantes disponibles sur macOS
voices=("Bubbles" "Zarvox" "Trinoids" "Whisper" "Cellos" "Albert" "Bahh")

# Liste de bruits de pets (onomatopées)
fart_sounds=("pfffft" "braaap" "plop" "tooooot" "prrrrt" "brap" "splat")

while true; do
    # Choisir une voix au hasard
    num_voices=${#voices[@]}
    random_voice=${voices[$((RANDOM % num_voices))]}

    # Choisir un son de pet au hasard
    num_sounds=${#fart_sounds[@]}
    random_sound=${fart_sounds[$((RANDOM % num_sounds))]}

    # "Dire" le son du pet avec la voix choisie
    say -v "$random_voice" "$random_sound"

    # Attendre un court instant aléatoire avant le prochain son
    sleep_duration=$(echo "scale=2; $RANDOM/16384.0 + 0.5" | bc)
    sleep $sleep_duration
done
