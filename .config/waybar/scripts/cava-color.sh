#!/bin/bash
config_file=$(mktemp)
cat > "$config_file" << 'CAVAEOF'
[general]
bars = 10

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
CAVAEOF

cava -p "$config_file" | while IFS= read -r line; do
    output=""
    IFS=';' read -ra bars <<< "$line"
    for bar in "${bars[@]}"; do
        case $bar in
            0) output+="▁" ;;
            1) output+="▂" ;;
            2) output+="▃" ;;
            3) output+="▄" ;;
            4) output+="▅" ;;
            5) output+="▆" ;;
            6) output+="▇" ;;
            7) output+="█" ;;
        esac
    done
    echo "$output"
done
