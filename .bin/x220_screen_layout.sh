#!/bin/bash
function LVDS1 {
    xrandr -d :0 \
        --output LVDS1 --mode 1366x768 --pos 0x0 --rotate normal \
        --output DP1 --off \
        --output DP2 --off \
        --output DP3 --off \
        --output HDMI1 --off \
        --output HDMI2 --off \
        --output HDMI3 --off \
        --output VGA1 --off
    echo "${FUNCNAME[0]}" > /tmp/mode
}

function DP1_above_LVDS1 {
    xrandr -d :0 \
        --output LVDS1 --primary --mode 1366x768 --pos 0x1080 --rotate normal \
        --output DP1 --mode 1920x1080 --pos 0x0 --rotate normal \
        --output DP2 --off \
        --output DP3 --off \
        --output HDMI1 --off \
        --output HDMI2 --off \
        --output HDMI3 --off \
        --output VGA1 --off \
        --output VIRTUAL1 --off
    echo "${FUNCNAME[0]}" > /tmp/mode
}

$($1)
nitrogen --restore
