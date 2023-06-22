#!/bin/sh

clean_up() {
    pactl unload-module "$mod0"
    pactl unload-module "$mod1"
    pactl unload-module "$mod2"
    exit
}

trap clean_up EXIT

mod0=$(pactl load-module module-null-sink sink_name=in_n_out)
mod1=$(pactl load-module module-loopback "source=`pactl get-default-sink`.monitor" sink=in_n_out rate=24000 latency_msec=50)
mod2=$(pactl load-module module-loopback "source=`pactl get-default-source`" sink=in_n_out rate=24000 latency_msec=50)

read dummy
