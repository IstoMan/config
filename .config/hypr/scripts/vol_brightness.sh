#!/bin/bash

# See README.md for usage instructions
volume_step=1
brightness_step=5
max_volume=100
notification_timeout=1000
show_album_art=true
show_music_in_volume_indicator=true
music_dir="$HOME/Music" # Set your music directory here

# Uses wpctl and awk to get volume
function get_volume {
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'
}

# Uses wpctl and grep to get mute status
function get_mute {
  if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED"; then
    echo "yes"
  else
    echo "no"
  fi
}

# Gets brightness from brillo
function get_brightness {
  brillo -G | cut -d'.' -f1
}

# Returns a mute icon, a volume-low icon, or a volume-high icon, depending on the volume
function get_volume_icon {
  volume=$(get_volume)
  mute=$(get_mute)
  if [ "$volume" -eq 0 ] || [ "$mute" == "yes" ]; then
    volume_icon="󰝟 "
  elif [ "$volume" -lt 50 ]; then
    volume_icon=""
  else
    volume_icon=""
  fi
}

# Always returns the same icon - I couldn't get the brightness-low icon to work with fontawesome
function get_brightness_icon {
  brightness_icon=""
}

function get_album_art {
  song_path="$music_dir/$(mpc -f "%file%" current)"
  album_art_path=$(find "$(dirname "$song_path")" -maxdepth 1 -type f \( -iname "cover.jpg" -o -iname "folder.jpg" -o -iname "cover.png" -o -iname "folder.png" \) | head -n1)
  if [ -n "$album_art_path" ]; then
    album_art="$album_art_path"
  else
    album_art=""
  fi
}

# Displays a volume notification
function show_volume_notif {
  volume=$(get_volume)
  get_volume_icon

  if [[ $show_music_in_volume_indicator == "true" ]]; then
    current_song=$(mpc -f "%title% - %artist%" current)

    if [[ $show_album_art == "true" ]]; then
      get_album_art
    fi

    notify-send -t $notification_timeout -h string:x-dunst-stack-tag:volume_notif -h int:value:$volume -i "$album_art" "$volume_icon $volume%" "$current_song"
  else
    notify-send -t $notification_timeout -h string:x-dunst-stack-tag:volume_notif -h int:value:$volume "$volume_icon $volume%"
  fi
}

# Displays a music notification
function show_music_notif {
  song_title=$(mpc -f "%title%" current)
  song_artist=$(mpc -f "%artist%" current)
  song_album=$(mpc -f "%album%" current)

  if [[ $show_album_art == "true" ]]; then
    get_album_art
  fi

  notify-send -t $notification_timeout -h string:x-dunst-stack-tag:music_notif -i "$album_art" "$song_title" "$song_artist - $song_album"
}

# Displays a brightness notification using dunstify
function show_brightness_notif {
  brightness=$(get_brightness)
  echo $brightness
  get_brightness_icon
  notify-send -t $notification_timeout -h string:x-dunst-stack-tag:brightness_notif -h int:value:$brightness "$brightness_icon $brightness%"
}

# Main function - Takes user input, "volume_up", "volume_down", "brightness_up", or "brightness_down"
case $1 in
volume_up)
  # Unmutes and increases volume, then displays the notification
  wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
  volume=$(get_volume)
  if [ $(("$volume" + "$volume_step")) -gt $max_volume ]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ $max_volume%
  else
    wpctl set-volume @DEFAULT_AUDIO_SINK@ ${volume_step}%+
  fi
  show_volume_notif
  ;;

volume_down)
  # Raises volume and displays the notification
  wpctl set-volume @DEFAULT_AUDIO_SINK@ ${volume_step}%-
  show_volume_notif
  ;;

volume_mute)
  # Toggles mute and displays the notification
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  show_volume_notif
  ;;

brightness_up)
  # Increases brightness and displays the notification
  brillo -q -A $brightness_step -u 100000
  show_brightness_notif
  ;;

brightness_down)
  # Decreases brightness and displays the notification
  brillo -q -U $brightness_step -u 100000
  show_brightness_notif
  ;;

next_track)
  # Skips to the next song and displays the notification
  mpc next
  sleep 0.5 && show_music_notif
  ;;

prev_track)
  # Skips to the previous song and displays the notification
  mpc prev
  sleep 0.5 && show_music_notif
  ;;

play_pause)
  mpc toggle
  show_music_notif
  # Pauses/resumes playback and displays the notification
  ;;
esac
