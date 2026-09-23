#!/usr/bin/env bash
#
# mango-keybinds-rofi.sh
# Shows all keybinds from your mangowm config in a rofi menu.
#
# Usage:
#   mango-keybinds-rofi.sh              # uses ~/.config/mango/config.conf
#   mango-keybinds-rofi.sh /path/to/config.conf
#
# Recognizes: bind=, bindr=, mousebind=, axisbind=
# Also follows source= includes, tracks keymode= sections, and uses
# a "# comment" on the line right above a bind as its description.
 
set -uo pipefail
 
CONFIG="${1:-${MANGO_CONFIG:-$HOME/.config/mango/config.conf}}"
 
if [[ ! -f "$CONFIG" ]]; then
    if [[ -f "/usr/share/mango/config.conf" ]]; then
        CONFIG="/usr/share/mango/config.conf"
    else
        echo "Config not found: $CONFIG" >&2
        exit 1
    fi
fi
 
# Recursively inline any `source=` lines so binds split across files show up too.
gather_config() {
    local file="$1" dir
    dir="$(dirname "$file")"
    while IFS= read -r line || [[ -n "$line" ]]; do
        if [[ "$line" =~ ^[[:space:]]*source=(.*)$ ]]; then
            local sourced="${BASH_REMATCH[1]}"
            [[ "$sourced" != /* ]] && sourced="$dir/$sourced"
            [[ -f "$sourced" ]] && gather_config "$sourced"
        else
            printf '%s\n' "$line"
        fi
    done < "$file"
}
 
# SUPER+SHIFT -> "SUPER + SHIFT", NONE -> ""
format_mods() {
    local mods="$1" upper
    upper="$(echo "$mods" | tr '[:lower:]' '[:upper:]')"
    [[ "$upper" == "NONE" || -z "$mods" ]] && { echo ""; return; }
    echo "${upper//+/ + }"
}
 
declare -a ENTRIES=()
current_mode="default"
last_comment=""
 
while IFS= read -r raw; do
    line="$(echo "$raw" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
 
    [[ -z "$line" ]] && { last_comment=""; continue; }
 
    if [[ "$line" == \#* ]]; then
        last_comment="$(echo "${line#\#}" | sed 's/^[[:space:]]*//')"
        continue
    fi
 
    if [[ "$line" =~ ^keymode=(.*)$ ]]; then
        current_mode="${BASH_REMATCH[1]}"
        last_comment=""
        continue
    fi
 
    if [[ "$line" =~ ^(bind|bindr|mousebind|axisbind)=(.*)$ ]]; then
        kind="${BASH_REMATCH[1]}"
        rest="${BASH_REMATCH[2]}"
 
        IFS=',' read -r mods key action params <<< "$rest"
        mods_fmt="$(format_mods "$mods")"
 
        combo="$key"
        [[ -n "$mods_fmt" ]] && combo="$mods_fmt + $key"
        case "$kind" in
            bindr)     combo="$combo  (release)" ;;
            mousebind) combo="$combo  (mouse)"   ;;
            axisbind)  combo="$combo  (scroll)"  ;;
        esac
 
        desc="$action"
        [[ -n "$params" ]] && desc="$action $params"
        [[ -n "$last_comment" ]] && desc="$last_comment   [$desc]"
 
        mode_tag=""
        [[ "$current_mode" != "default" ]] && mode_tag="  <${current_mode}>"
 
        ENTRIES+=("$(printf '%-26s  %s%s' "$combo" "$desc" "$mode_tag")")
        last_comment=""
        continue
    fi
 
    last_comment=""
done < <(gather_config "$CONFIG")
 
if [[ ${#ENTRIES[@]} -eq 0 ]]; then
    echo "No keybinds found in $CONFIG" | rofi -dmenu -p "Mango Keybinds" -no-custom
    exit 0
fi
 
printf '%s\n' "${ENTRIES[@]}" | sort | rofi -dmenu -i -p "Mango Keybinds" -no-custom -width 60
 

