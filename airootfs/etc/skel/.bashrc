#
# ~/.bashrc - BerzeliusOS Shell Configuration
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -la'
alias beaker='berzelius-welcome'
alias calc='berzelius-calc'
alias titrate='berzelius-calc --titrate'
alias prep='berzelius-calc --prep'
alias install-os='sudo archinstall'
alias update='sudo berzelius-update'
alias fetch='fastfetch -c /etc/fastfetch/config.jsonc'

# Berzelius Laboratory Prompt
# Shows cyan glassware flask icon and clean path
PS1='\[\033[1;36m\]🧪 [Bz] \[\033[1;32m\]\u@berzelius \[\033[1;34m\]\w \[\033[1;36m\]\$ \[\033[0m\]'

# Display system laboratory metrics on terminal opening
if [ -f /etc/fastfetch/config.jsonc ] && [ -z "$FASTFETCH_RAN" ]; then
    export FASTFETCH_RAN=1
    fastfetch -c /etc/fastfetch/config.jsonc
fi
