#!/usr/bin/env bash

# Define the log file

LOGFILE="$HOME/public_ip_log.txt"
IPV4FILE="$HOME/current_ipv4.txt"
IPV6FILE="$HOME/current_ipv6.txt"

# Get current IP addrs
CURRENT_IPV4=$(curl -s -4 ifconfig.me)
CURRENT_IPV6=$(curl -s -6 ifconfig.me)

# Check and log IPv4 changes
if [ ! -f "IPV4FILE" ]; then
    echo "$CURRENT_IPV4" > "$IPV4FILE"
else
    PREV_IPV4=$(cat "$IPV4FILE")
    if [ "$CURRENT_IPV4" != "$PREV_IPV4" ]; then
        echo "$(date) - IPv4 Changed: $PREV_IPV4 → $CURRENT_IPV4" | tee -a "$LOGFILE" | mail -s "Public IPv4 Changed" terraclast@gmail.com
        echo "$CURRENT_IPV4" > "IPV4FILE"
    fi
fi

# Check and log IPv6  changes
if [ ! -f "$IPV6FILE" ]; then
    echo "$CURRENT_IPV6" > "$IPV6FILE"
else
    PREV_IPV6=$(cat "$IPV6FILE")
    if [ "$CURRENT_IPV6" != "$PREV_IPV6" ]; then
        echo "$(date) - IPv6 Changed: $PREV_IPV6 → $CURRENT_IPV6" | tee -a "$LOGFILE" | mail -s "Public IPv6 Changed" terraclast@gmail.com
        echo "$CURRENT_IPV6" > "$IPV6FILE"
    fi
fi
