#!/bin/bash
# Aliases custom to Ubuntu








# DNS Restart
alias dnsrestart="sudo /etc/init.d/nscd restart"

# Quick synaptic
alias synap="sudo synaptic"
alias esynap="se /etc/apt/sources.list" # manually edit sources

# Opening Files fast, more like mac
alias open="gvfs-open" #"gnome-open"

# Get Ubuntu version
alias myubuntu="more /etc/issue"


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

